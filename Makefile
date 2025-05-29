.DEFAULT_GOAL := all
.SHELLFLAGS := -e -c
SHELL := $(shell command -v sh)

## Enviroment overridable variables
CURDIR ?= {PWD}
OUT ?= $(CURDIR)/outputs
out ?= $(OUT)
SRC ?= $(CURDIR)
VERBOSE ?= 1
FORCE ?= 0
LANG ?= C.UTF-8
XETEX ?= xelatex

### Installation paths
PREFIX ?= usr/local
DOCDIR ?= share/doc/awesome-cv
EXAMPLEDIR ?= $(addsuffix /examples,$(DOCDIR))
DESTDIR ?= $(PREFIX)/

## Commandline overridable (internal) variables
src = $(SRC)

examples_dir = $(src)/examples

coverletter_dir = $(examples_dir)
coverletter_srcs =
coverletter_srcs += $(coverletter_dir)/coverletter.tex
coverletter_srcs += $(src)/awesome-cv.cls
coverletter_deps = $(patsubst $(src)/%,$(out)/%,$(coverletter_srcs))

resume_dir = $(examples_dir)/resume
resume_srcs =
resume_srcs += $(shell find "$(resume_dir)" -name "*.tex")
resume_srcs += $(src)/awesome-cv.cls
resume_deps = $(patsubst $(src)/%,$(out)/%,$(resume_srcs))

cv_dir = $(examples_dir)/cv
cv_srcs =
cv_srcs += $(shell find "$(cv_dir)" -name "*.tex")
cv_srcs += $(src)/awesome-cv.cls
cv_deps = $(patsubst $(src)/%,$(out)/%,$(cv_srcs))

out_dirs = $(sort $(dir \
$(coverletter_deps) \
$(resume_deps) \
$(cv_deps) \
))

install_dest_dir = $(DESTDIR)
install_doc_dir = $(install_dest_dir)$(DOCDIR)
install_example_dir = $(install_dest_dir)$(EXAMPLEDIR)

force =
ifneq ($(strip $(filter-out 0,$(FORCE))),)
force = .force_non_existing
endif

silent =
ifeq ($(strip $(filter-out 0,$(VERBOSE))),)
silent = @
endif

## Resolve lazy variables
force := $(force)
silent := $(silent)
install_dest_dir := $(install_dest_dir)
install_doc_dir := $(install_doc_dir)
install_example_dir := $(install_example_dir)
src := $(src)
out := $(out)
out_dirs := $(out_dirs)

## Sentinel checks
ifeq ($(strip $(out)),)
$(error Output directory should be set to a value (OUT=))
endif
ifeq ($(strip $(src)),)
$(error Source directory should be set to a value (SRC=))
endif
ifeq ($(realpath $(out)),$(realpath $(src)))
$(error Output directory should not point to source tree (OUT <=> SRC='$(src)'))
endif

## (Re-)Exported variables
export LANG

.DELETE_ON_ERROR:

.ONE_SHELL:

.SUFFIXES:

.PHONY: examples
examples: \
$(out)/examples/coverletter.pdf \
$(out)/examples/cv.pdf \
$(out)/examples/resume.pdf

$(out)/%/resume.pdf: $(out)/%/resume.tex $(resume_deps) $(force) $(MAKEFILE_LIST) | $(out_dirs)
	$(silent)"$(XETEX)" -output-directory="$(patsubst %/,%,$(dir $@))" "$<" 0<&-

$(out)/%/cv.pdf: $(out)/%/cv.tex $(cv_deps) $(force) $(MAKEFILE_LIST) | $(out_dirs)
	$(silent)"$(XETEX)" -output-directory="$(patsubst %/,%,$(dir $@))" "$<" 0<&-

$(out)/%/coverletter.pdf: $(out)/%/coverletter.tex $(coverletter_deps) $(force) $(MAKEFILE_LIST) | $(out_dirs)
	$(silent)"$(XETEX)" -output-directory="$(patsubst %/,%,$(dir $@))" "$<" 0<&-

$(out)/%.cls : $(src)/%.cls | $(out_dirs)
	$(silent)ln -sf "$<" "$@"

$(out)/%.tex : $(src)/%.tex | $(out_dirs)
	$(silent)ln -sf "$<" "$@"

$(out_dirs):
	$(silent)mkdir -p "$@"

$(force): ;

.PHONY: pdf
pdf: examples

.PHONY: all
all: pdf

.PHONY: clean
clean:
	$(silent)rm -rf "$(out)"

.PHONY: println-%
println-%:
	@printf -- '%s\n' "$*" 1>&2
	@printf -- '%s\n' $(foreach v,$($*),"$(v)")

.PHONY: install
install: all
	$(silent)install -d "$(install_doc_dir)"
	$(silent)install -d "$(install_example_dir)"
	$(silent)install -m 644 $(out)/examples/*.pdf "$(install_example_dir)/"
	$(silent)install -m 644 README.md "$(install_doc_dir)/"
	$(silent)install -m 644 awesome-cv.cls "$(install_doc_dir)/"

.PHONY: uninstall
uninstall:
	$(silent)rm -rf "$(install_doc_dir)" "$(install_example_dir)"

.PHONY: help
help:
	@{ \
		echo "Usage: make [target] [VARIABLE=value]"; \
		echo "Available targets:"; \
		echo "  all          - Build all examples (default)"; \
		echo "  pdf          - Build PDF files"; \
		echo "  examples     - Build all example PDFs"; \
		echo "  clean        - Clean output directory"; \
		echo "  install      - Install the documentation and examples"; \
		echo "  uninstall    - Uninstall the documentation and examples"; \
		echo "  help         - Show this help message"; \
		echo ""; \
		echo "Overridable variables:"; \
		echo "  OUT          - Output directory (default: outputs)"; \
		echo "  SRC          - Source directory (default: current directory)"; \
		echo "  VERBOSE      - Verbosity level (0 for silent, default: 1)"; \
		echo "  FORCE        - Force rebuild (0 for no, default: 0)"; \
		echo "  LANG         - Language setting for LaTeX (default: C.UTF-8)"; \
		echo "  XETEX        - LaTeX engine to use (default: xelatex)"; \
		echo ""; \
		echo "Example usage:"; \
		echo "  make pdf OUT=outputs SRC=src VERBOSE=1 FORCE=1"; \
		echo "  make install DESTDIR=/usr/local"; \
		echo "  make uninstall DESTDIR=/usr/local"; \
	}
