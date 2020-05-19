#!/bin/bash
# compile cv.tex to produce cv.pdf and
# remove temporary files generated during compilation
# Usage: sh compile_cv.sh
# Author: Ravi Joshi
# Date: 16 June 2019
# -------------------------------------------------

# declare all temporary files
temp_file_extensions="aux bbl bcf blg log out run.xml"

# function
compile_tex()
{
    file_name=$1

    echo "Running xelatex. Please wait..."
    xelatex "${file_name}.tex"

    echo "Running biber. Please wait..."
    biber "${file_name}"

    echo "Running xelatex again. Please wait..."
    xelatex "${file_name}.tex"

    echo "Running xelatex again. Please wait..."
    xelatex "${file_name}.tex"

    echo "Removing temporary files. Please wait..."
    for temp_file_extension in $temp_file_extensions
    do
        rm  "${file_name}.${temp_file_extension}"
    done
    
    echo "Finished."
}

compile_tex cv
