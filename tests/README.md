# PDF quality checks

From the repository root, use the same command as CI:

```sh
docker build --tag awesome-cv .
docker run --rm --user "$(id -u):$(id -g)" --volume "$PWD:/doc" awesome-cv make test
```

For a native TeX installation, install Python 3 and
[PyMuPDF](https://pymupdf.readthedocs.io/en/latest/installation.html), then run
`make test`. `PYTHON` and `LATEXMK` can be overridden with Make variables.
Use Docker when comparing results with CI.

The test command builds all examples and three focused fixtures, then checks:

- Expected page counts, A4/US Letter dimensions, readable text on every page,
  embedded fonts, and absence of Type 3 fonts.
- Empty and short section headings, spaces, accents, ligatures, and the bold
  heading face (regression coverage for #529).
- Exact homepage, email, and GitHub URI annotations; optional honor punctuation.
- Consistent distance from the role to the first bullet in one- and two-item
  entries (regression coverage for #532).
- Missing characters and font substitution warnings in compiler logs.

`build/quality/` contains a JSON report and opaque PNGs of every page for visual
review. CI uploads these together with PDFs and logs, including after a failed
check. If compilation stops first, available compiler logs are still uploaded.

Page counts are deliberately explicit in `check_pdfs.py`. When content changes,
inspect the rendered pages before changing the expectation. Do not update it
just to make CI green. These checks do not certify ATS compatibility, PDF/UA
accessibility, or every visual detail; reviewers still need to inspect layout.

Existing overfull/underfull box warnings are recorded in the JSON report rather
than failing the suite. For example, header width (#103), adjacent entries
without blank lines (#112), empty entry header rows (#327), and multi-page
entries (#331) remain open limitations. This suite does not silently fix or
approve those cases. Add a focused fixture and an assertion when fixing one.
