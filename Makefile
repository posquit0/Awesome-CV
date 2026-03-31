.PHONY: examples derek

CC = lualatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
DEREK_CV_DIR = cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
DEREK_CV_SRCS = $(shell find $(DEREK_CV_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf)

derek: derek.pdf

derek.pdf: derek.tex $(DEREK_CV_SRCS)
	$(CC) derek.tex

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
