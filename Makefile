.PHONY: examples

CC = xelatex
RESUME_DIR = resume

resume.pdf: resume.tex ${RESUME_DIR}
	$(CC) -output-directory=. $<
