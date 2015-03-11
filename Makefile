PDF=01_wstep.pdf 02_zastosowania.pdf 03_aksjomatyka.pdf 04_warunkowe.pdf

all: $(PDF)

$(PDF): mp.cls beamercolorthemePUT.sty beamerthemePUT.sty

%.pdf: %.tex
	pdflatex $^

01_wstep.pdf: bayes/Spy_silhouette.pdf

#ftp://ftp.gust.org.pl/TeX/info/svg-inkscape/InkscapePDFLaTeX.pdf
%.pdf: %.svg
	inkscape -D -z --file=$^ --export-pdf=$@ --export-latex
