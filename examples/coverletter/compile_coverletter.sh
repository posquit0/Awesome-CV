#!/bin/bash
# compile coverletter.tex to produce coverletter.pdf and
# remove temporary files generated during compilation
# Usage: sh compile_coverletter.sh
# Author: Ravi Joshi
# Date: 26 Aug 2019
# -------------------------------------------------

# declare all temporary files
temp_file_extensions="aux bcf log out run.xml"

# function
compile_tex()
{
    file_name=$1

    echo "Running xelatex. Please wait..."
    xelatex "${file_name}.tex"

    echo "Removing temporary files. Please wait..."
    for temp_file_extension in $temp_file_extensions
    do
        rm  "${file_name}.${temp_file_extension}"
    done

    echo "Finished."
}

compile_tex coverletter
