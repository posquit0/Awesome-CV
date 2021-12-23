.PHONY: contents

CC = xelatex
CONTENTS_DIR = contents
RESUME_DIR = contents/resume
CV_DIR = contents/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

contents: $(foreach x,  cv, $x.pdf) # coverletter resume ...

# resume.pdf: $(CONTENTS_DIR)/resume.tex $(RESUME_SRCS)
# 	$(CC) -output-directory=$(CONTENTS_DIR) $<

cv.pdf: $(CONTENTS_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(CONTENTS_DIR) $<

# coverletter.pdf: $(CONTENTS_DIR)/coverletter.tex
# 	$(CC) -output-directory=$(CONTENTS_DIR) $<

clean: 
	cd contents \
	&& rm *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.xml *.toc *.pdf
