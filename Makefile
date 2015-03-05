all: intro.pdf

intro.pdf: intro.tex
	pdflatex intro.tex
