LMKFLAGS = -outdir=samples -bibtex
CLASSDIR =  $$(kpsewhich -var-value TEXMFHOME)/tex/latex/tufte-latex
DOCDIR =  $$(kpsewhich -var-value TEXMFHOME)/doc/latex/tufte-latex

test-lua:
	latexmk $(LMKFLAGS) -lualatex -jobname=%A-lualatex *.tex

test-xe:
	latexmk $(LMKFLAGS) -xelatex -jobname=%A-xelatex *.tex

test-pdf:
	latexmk $(LMKFLAGS) -pdflatex -jobname=%A-pdflatex *.tex

test: test-lua test-xe test-pdf

install: test
	mkdir -p $(CLASSDIR)
	cp tufte-book.cls tufte-common.def tufte-handout.cls $(CLASSDIR)
	mkdir -p $(DOCDIR)
	cp History.txt \
		README.md \
		sample-*.tex \
		sample-*.bib \
		samples/sample-*.pdf \
		$(DOCDIR)
	texhash
