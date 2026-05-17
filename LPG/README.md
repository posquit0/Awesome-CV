# LPG Resume

LaTeX resume built with [Awesome-CV](https://github.com/posquit0/Awesome-CV).

## Building

```bash
cd LPG
xelatex resume.tex
```

Run twice to resolve cross-references.

## Required Fonts

The build requires **FontAwesome** and **Roboto** fonts in a `fonts/` directory
at the repo root (i.e., `../fonts/` relative to this directory). This directory
is not tracked in source control.

### Option 1: TeX Live (recommended)

If you have [TeX Live](https://www.tug.org/texlive/) installed, the fonts are
already bundled. Create symlinks from the repo root:

```bash
# From the repo root
mkdir -p fonts

# FontAwesome
TEXLIVE=/usr/local/texlive/2025
ln -s $TEXLIVE/texmf-dist/fonts/opentype/public/fontawesome/FontAwesome.otf fonts/

# Roboto
ROBOTO=$TEXLIVE/texmf-dist/fonts/opentype/google/roboto
for f in Roboto-Regular Roboto-Italic Roboto-Bold Roboto-BoldItalic \
          Roboto-Thin Roboto-ThinItalic Roboto-Medium Roboto-MediumItalic; do
  ln -s $ROBOTO/$f.otf fonts/
done
```

Adjust the `TEXLIVE` path if your installation year differs (e.g., `2024`).

### Option 2: Download directly

Download the fonts and place them in a `fonts/` directory at the repo root:

- **FontAwesome 4.7** — [FontAwesome.otf](https://github.com/FortAwesome/Font-Awesome/releases/tag/v4.7.0)
  (download the zip, extract `fonts/FontAwesome.otf`)
- **Roboto** — [Google Fonts](https://fonts.google.com/specimen/Roboto)
  (download the family, you need: Regular, Italic, Bold, Bold Italic, Thin,
  Thin Italic, Medium, Medium Italic)

Rename the Roboto files to match the pattern `Roboto-<Weight>.otf` if needed.
