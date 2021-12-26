.PHONY: clean
CV_DIR = cv
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

cv.pdf: cv.tex $(CV_SRCS) 
	xelatex cv.tex \
	&& biber cv \
	&& xelatex cv.tex

clean: 
	rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.xml *.toc
