#!/bin/sh

docker run --rm -w "/data/examples" -v "$PWD":/data blang/latex xelatex cv.tex
