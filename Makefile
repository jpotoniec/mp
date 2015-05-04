SRC=01_wstep.tex 02_zastosowania.tex 03_aksjomatyka.tex 04_warunkowe.tex 05_zmienne.tex 06_momenty.tex 07_rozklady.tex 08_montecarlo.tex 09_ciagle.tex 10_korelacja.tex
NOTES_SRC=$(shell grep -l '\\note' $(SRC))

PDF=$(SRC:%.tex=%.pdf) $(NOTES_SRC:%.tex=%_notes.pdf)

all: $(PDF)

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
	octave -qf ./$^ |sed 's/\./{,}/g' > $@

07_rozklady.pdf: poisson.tex

09_ciagle.pdf: gauss.tex

index.html: gen_index.pe Makefile
	./gen_index.pe $(SRC) >$@

publish: $(PDF) index.html
	rsync $(PDF) index.html libra.cs.put.poznan.pl:public_html/mp/

.PHONY: all clean publish
