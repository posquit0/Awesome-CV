.PHONY: contents

CC = xelatex
CONTENTS_DIR = contents
RESUME_DIR = contents/resume
CV_DIR = contents/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

contents: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(CONTENTS_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(CONTENTS_DIR) $<

cv.pdf: $(CONTENTS_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(CONTENTS_DIR) $<

coverletter.pdf: $(CONTENTS_DIR)/coverletter.tex
	$(CC) -output-directory=$(CONTENTS_DIR) $<

clean:
	rm -rf $(CONTENTS_DIR)/*.pdf
