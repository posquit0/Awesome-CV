"""Check compiled PDFs; run from the repository root with `make test`."""

import json
from pathlib import Path
import re
import sys
import unicodedata

import pymupdf


OUTPUT = Path("build/quality")
OUTPUT.mkdir(parents=True, exist_ok=True)
failures = []
report = []


def check(condition, message):
    if not condition:
        failures.append(message)


def normalized(text):
    return " ".join(unicodedata.normalize("NFC", text).split())


# Page counts are reviewed expectations, not automatically regenerated baselines.
documents = {
    "coverletter": (Path("build/coverletter.pdf"), 1),
    "cv": (Path("build/cv.pdf"), 5),
    "resume": (Path("build/resume.pdf"), 3),
    "sections": (Path("build/tests/sections.pdf"), 1),
    "header": (Path("build/tests/header.pdf"), 1),
    "spacing": (Path("build/tests/spacing.pdf"), 1),
}

for name, (path, pages) in documents.items():
    try:
        with pymupdf.open(path) as doc:
            check(not doc.is_repaired, f"{name}: PDF required structural repair")
            check(doc.page_count == pages,
                  f"{name}: expected {pages} pages, got {doc.page_count}")
            text = normalized(" ".join(page.get_text() for page in doc))
            font_names = set()
            for page in doc:
                label = f"{name} page {page.number + 1}"
                expected_size = (612, 792) if name == "header" else (595.28, 841.89)
                check(all(abs(a - b) < 1 for a, b in
                          zip((page.rect.width, page.rect.height), expected_size)),
                      f"{label}: unexpected paper size {page.rect}")
                check(bool(page.get_text().strip()), f"{label}: empty text layer")
                check("\ufffd" not in page.get_text(),
                      f"{label}: replacement character in text layer")
                for font in page.get_fonts(full=True):
                    xref, _, kind, base_name = font[:4]
                    font_names.add(base_name)
                    check(kind != "Type3", f"{label}: Type 3 font {base_name}")
                    check(xref > 0 and bool(doc.extract_font(xref)[3]),
                          f"{label}: font is not embedded: {base_name}")
                # Opaque PNGs are review artifacts, not pixel-perfect snapshots.
                page.get_pixmap(dpi=100, alpha=False).save(
                    OUTPUT / f"{name}-{page.number + 1}.png")

            check(any("SourceSans3" in font for font in font_names),
                  f"{name}: Source Sans 3 is missing")
            if name in ("coverletter", "cv", "resume", "header"):
                check(any("Roboto" in font for font in font_names),
                      f"{name}: Roboto is missing")
            if name == "sections":
                for phrase in ("A Section Here", "An Example", "Education",
                               "José writes a résumé with efficient office workflows."):
                    check(phrase in text, f"{name}: text extraction lost {phrase!r}")
                lines = [normalized(line) for line in doc[0].get_text().splitlines()]
                for heading in ("A", "AI"):
                    check(heading in lines, f"{name}: missing short heading {heading!r}")
                for block in doc[0].get_text("dict")["blocks"]:
                    for line in block.get("lines", []):
                        for span in line["spans"]:
                            if span["size"] > 15 and span["text"].strip():
                                check("SourceSans3-Bold" in span["font"],
                                      f"{name}: heading lost bold face: {span}")
            elif name == "header":
                links = {link.get("uri") for page in doc for link in page.get_links()}
                for uri in ("https://example.com", "mailto:quality@example.com",
                            "https://github.com/quality-example"):
                    check(uri in links, f"{name}: missing or changed link {uri}")
                check("AwardOnly," not in text, f"{name}: dangling honor comma")
                check("Winner, EventName" in text, f"{name}: missing honor separator")
                check(any("FontAwesome" in font for font in font_names),
                      f"{name}: icon font is missing")
            elif name == "spacing":
                def top(word):
                    matches = doc[0].search_for(word)
                    if len(matches) != 1:
                        raise ValueError(f"expected one {word!r}, got {len(matches)}")
                    return matches[0].y0

                one_gap = top("ItemOne") - top("RoleOne")
                two_gap = top("ItemTwoA") - top("RoleTwo")
                check(0 < one_gap < 20 and abs(one_gap - two_gap) < 1,
                      f"{name}: unequal first-item gaps: {one_gap:.2f}, {two_gap:.2f} pt")

            log = path.with_suffix(".log").read_text()
            for pattern in (r"Missing character:", r"LaTeX Font Warning:",
                            r"Package fontspec Warning:"):
                check(not re.search(pattern, log), f"{name}: {pattern} in compiler log")
            warnings = re.findall(r"(?:Over|Under)full \\[hv]box[^\n]*", log)
            report.append({"document": name, "pages": doc.page_count,
                           "fonts": sorted(font_names), "box_warnings": warnings})
    except (OSError, RuntimeError, ValueError) as error:
        failures.append(f"{name}: {error}")

(OUTPUT / "report.json").write_text(
    json.dumps({"documents": report, "failures": failures}, indent=2) + "\n")
for failure in failures:
    print(f"FAIL: {failure}", file=sys.stderr)
print(f"Checked {len(documents)} PDFs; {len(failures)} failures. See {OUTPUT}.")
sys.exit(bool(failures))
