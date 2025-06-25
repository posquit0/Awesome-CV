.PHONY: examples resume.pdf cv.pdf coverletter.pdf docker-resume docker-cv docker-coverletter clean

CC = xelatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
DOCKER_IMAGE = aachraf/latex-cv-docker

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

docker-resume:
	docker run --rm -v $(PWD):/doc $(DOCKER_IMAGE) make resume.pdf

docker-cv:
	docker run --rm -v $(PWD):/doc $(DOCKER_IMAGE) make cv.pdf

docker-coverletter:
	docker run --rm -v $(PWD):/doc $(DOCKER_IMAGE) make coverletter.pdf

docker:
	docker run --rm -v $(PWD):/doc $(DOCKER_IMAGE) make examples

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
