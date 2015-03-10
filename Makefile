all: intro.pdf

intro.pdf: intro.tex beamercolorthemePUT.sty beamerthemePUT.sty
	pdflatex intro.tex

intro.pdf: bayes/Spy_silhouette.pdf

#ftp://ftp.gust.org.pl/TeX/info/svg-inkscape/InkscapePDFLaTeX.pdf
%.pdf: %.svg
	inkscape -D -z --file=$^ --export-pdf=$@ --export-latex
