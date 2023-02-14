.PHONY: examples

CC = xelatex
EXAMPLES_DIR = examples
EXMAPLE_RESUME_DIR = examples/resume
EXAMPLE_CV_DIR = examples/cv
EXAMPLE_RESUME_SRCS = $(shell find $(EXMAPLE_RESUME_DIR) -name '*.tex')
EXAMPLE_CV_SRCS = $(shell find $(EXAMPLE_CV_DIR) -name '*.tex')

SECTIONS_DIR = sections
CV_SRCS = $(shell find $(SECTIONS_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, example/$x.pdf)

exmaple/resume.pdf: $(EXAMPLES_DIR)/resume.tex $(EXAMPLE_RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

example/cv.pdf: $(EXAMPLES_DIR)/cv.tex $(EXAMPLE_CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

example/coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: cv.tex $(CV_SRCS)
	$(CC) $<

coverletter.pdf: coverletter.tex $(CV_SRCS)
	$(CC) $<

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
