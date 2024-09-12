.PHONY: examples clean all cv resume coverletter personal

# Variables
CC = xelatex

# Example directories and source files
EXAMPLES_DIR = examples
EXAMPLES_RESUME_DIR = examples/resume
EXAMPLES_RESUME_SRCS = $(shell find $(EXAMPLES_RESUME_DIR) -name '*.tex')
EXAMPLES_CV_DIR = examples/cv
EXAMPLES_CV_SRCS = $(shell find $(EXAMPLES_CV_DIR) -name '*.tex')

# Personal directories and files (adjust these paths to your personal .tex files)
DIR = $(shell pwd)
CV_DIR = cv
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
RESUME_DIR = resume
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
# RESUME_SRCS = resume/resume.tex
# CV_SRCS = $(DIR)/cv.tex
COVERLETTER_SRC = coverletter/coverletter.tex

# Default target (creates personal CV, resume, and cover letter)
all: personal

personal: cv resume coverletter

# Targets for personal files
cv: $(DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(DIR) $<

resume: $(DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(DIR) $<

coverletter: $(COVERLETTER_SRC)
	$(CC) -output-directory=$(DIR) $<

# Example targets
examples: example_cv example_resume example_coverletter

example_resume: $(EXAMPLES_DIR)/resume.tex $(EXAMPLES_RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

example_cv: $(EXAMPLES_DIR)/cv.tex $(EXAMPLES_CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

example_coverletter: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

# Clean up
clean:
	rm -rf $(DIR)/*.pdf $(EXAMPLES_DIR)/*.pdf
