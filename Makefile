.PHONY: examples

resume: latex/resume.pdf

%.pdf: %.tex latex/sections/*.tex awesome-cv.cls
	xelatex -output-directory=$(dir $@) $<
