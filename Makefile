SLIDES=01_wstep.pdf 02_zastosowania.pdf 03_aksjomatyka.pdf 04_warunkowe.pdf 05_zmienne.pdf 06_momenty.pdf 07_rozklady.pdf 08_montecarlo.pdf
NOTES_SRC=$(shell grep -l '\\note' $(SLIDES:%.pdf=%.tex))

PDF=$(SLIDES) $(NOTES_SRC:%.tex=%_notes.pdf)

all: $(PDF) $(NOTES)

$(PDF): mp.cls beamercolorthemePUT.sty beamerthemePUT.sty

%.pdf: %.tex
	pdflatex $^
	pdflatex $^

%_notes.pdf: %.tex
	pdflatex -jobname $(<:%.tex=%_notes) "\\def\\notatki{}\\input{$<}"
	pdflatex -jobname $(<:%.tex=%_notes) "\\def\\notatki{}\\input{$<}"

04_warunkowe.pdf: 04_warunkowe/bayes/Spy_silhouette.pdf

#ftp://ftp.gust.org.pl/TeX/info/svg-inkscape/InkscapePDFLaTeX.pdf
%.pdf: %.svg
	inkscape -D -z --file=$^ --export-pdf=$@ --export-latex

clean:
	rm -f $(PDF) $(PDF:%.pdf=%.aux) $(PDF:%.pdf=%.log) $(PDF:%.pdf=%.nav) $(PDF:%.pdf=%.out) $(PDF:%.pdf=%.snm) $(PDF:%.pdf=%.toc)

%.tex: %.m
	octave -qf ./$^ > $@

07_rozklady.pdf: poisson.tex

.PHONY: all clean
