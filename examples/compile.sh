#!/bin/bash
# compile cv.tex to produce cv.pdf and
# remove temporary files generated during compilation
# Usage: sh compile.sh
# Author: Ravi Joshi
# Date: 16 June 2019
# -------------------------------------------------

echo "Running xelatex. Please wait..."
xelatex cv.tex

echo "Running biber. Please wait..."
biber cv

echo "Running xelatex. Please wait..."
xelatex cv.tex

echo "Removing temporary files. Please wait..."
rm cv.aux cv.bbl cv.bcf cv.blg cv.log cv.out cv.run.xml

echo "Finished."
