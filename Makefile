.PHONY: examples resume.pdf cv.pdf coverletter.pdf clean distclean

LATEXMK = latexmk

examples:
	$(LATEXMK)

resume.pdf cv.pdf coverletter.pdf:
	$(LATEXMK) examples/$(@:.pdf=.tex)

clean:
	$(LATEXMK) -c

distclean:
	$(LATEXMK) -C
