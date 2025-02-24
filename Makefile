.PHONY: examples docker

CC = xelatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
DOCKER_CMD = docker run --rm --user $(shell id -u):$(shell id -g) -i -w "/doc" -v "$(PWD)":/doc thomasweise/texlive make

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

docker-resume:
	$(DOCKER_CMD) resume.pdf

docker-cv:
	$(DOCKER_CMD) cv.pdf

docker-coverletter:
	$(DOCKER_CMD) coverletter.pdf

docker:
	$(DOCKER_CMD) examples

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
