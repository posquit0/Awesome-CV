.PHONY: documents

CC = xelatex
DOCUMENTS_DIR = documents
CONTENTS_DIR = contents
FRONTEND_DIR = ${CONTENTS_DIR}/frontend
FRONTEND_SRCS = $(shell find $(FRONTEND_DIR) -name '*.tex')

examples: $(foreach x, resume-fullstack resume-frontend, $x.pdf)

resume-frontend.pdf: $(DOCUMENTS_DIR)/resume-frontend.tex $(FRONTEND_SRCS)
	$(CC) -output-directory=$(DOCUMENTS_DIR) $<

coverletter.pdf: $(DOCUMENTS_DIR)/coverletter.tex
	$(CC) -output-directory=$(OUTPUT_DIR) $<

resume-fullstack.pdf: $(DOCUMENTS_DIR)/resume-fullstack.tex
	$(CC) -output-directory=$(DOCUMENTS_DIR) $<

clean:
	rm -rf $(DOCUMENTS_DIR)/*.pdf
