#!/bin/bash
# compile coverletter.tex to produce coverletter.pdf and
# remove temporary files generated during compilation
# Usage: sh compile_coverletter.sh
# Author: Ravi Joshi
# Date: 26 Aug 2019
# -------------------------------------------------

echo "Running xelatex. Please wait..."
xelatex coverletter.tex

echo "Removing temporary files. Please wait..."
#rm -v !("coverletter.tex"|"coverletter.pdf")
rm coverletter.aux coverletter.bcf coverletter.log coverletter.out coverletter.run.xml

echo "Finished."
