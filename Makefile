.PHONY: clean
CV_DIR = cv
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

CL_DIR = cl
CL_SRCS = $(shell find $(CL_DIR) -name '*.tex')

cv.pdf: cv.tex $(CV_SRCS) 
	xelatex cv.tex \
	&& biber cv \
	&& xelatex cv.tex

coverletter.pdf: coverletter.tex $(CL_SRCS) 
	xelatex coverletter.tex

clean: 
	rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.xml *.toc
