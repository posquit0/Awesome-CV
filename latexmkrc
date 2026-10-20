# Run latexmk from the repository root so input and image paths are consistent.
$pdf_mode = 4;
$lualatex = 'lualatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S';
$out_dir = 'build';
@default_files = (
    'examples/coverletter.tex',
    'examples/cv.tex',
    'examples/resume.tex',
);
