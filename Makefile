.PHONY: examples

examples: $(foreach x,coverletter cv resume,examples/$x.pdf)

%.pdf: %.tex
	xelatex -output-directory=$(dir $@) $<
