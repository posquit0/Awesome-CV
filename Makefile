
cv.pdf: cv.tex cv
	xelatex cv.tex \
	&& biber cv \
	&& xelatex cv.tex

clean: 
	rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.xml *.toc
