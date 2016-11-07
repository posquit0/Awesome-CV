.PHONY: examples

resume: latex/resume.pdf

%.pdf: %.tex
	xelatex -output-directory=$(dir $@) $<
