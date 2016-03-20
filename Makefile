SRC=01_wstep.tex 02_zastosowania.tex 03_aksjomatyka.tex 04_warunkowe.tex 05_zmienne.tex 06_momenty.tex 07_rozklady.tex 08_montecarlo.tex 09_ciagle.tex 10_korelacja.tex 11_ciagi.tex cwiczenia.tex 12_procesy.tex 13_lancuchy_markowa.tex 14_proces_poissona.tex
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

11_ciagi.pdf: circles.tex ll.tex

%.image.pdf: %.image.tex %.tex
	pdflatex -output-directory "$(dir $@)" "$<"

%.png: %.image.pdf
	./convert.sh "$^" "$@"
	touch "$@"	#moze byc tak, ze powstana pliki %-liczba.png, ale wtedy i tak chcemy miec plik %.png, zeby make nie wariowalo

12_procesy.pdf: 12_procesy/thinx.tex 12_procesy/mean.png 12_procesy/corr.png

%.tex: %.pe
	./$^ >$@

12_procesy/thinx.tex 12_procesy/mean.tex 12_procesy/corr.tex: 12_procesy/thinx.pe 12_procesy/thinx-weekly.csv
	./12_procesy/thinx.pe <12_procesy/thinx-weekly.csv 12_procesy/thinx.tex 12_procesy/mean.tex 12_procesy/corr.tex

index.html: gen_index.pe Makefile $(SRC)
	./gen_index.pe $(SRC) >$@

publish: $(PDF) index.html
	rsync $(PDF) index.html libra.cs.put.poznan.pl:public_html/mp/

.PHONY: all clean publish
