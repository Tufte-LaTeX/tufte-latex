sample-handout:
	pdflatex sample-handout
	bibtex   sample-handout
	pdflatex sample-handout
	pdflatex sample-handout
sample-book:
	pdflatex sample-book
	bibtex sample-book
	texindy --language english sample-book.idx
	# or makeindex sample-book.idx
	pdflatex sample-book
	pdflatex sample-book
	pdflatex sample-book
