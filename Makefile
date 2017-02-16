SRC=01_wstep.tex 02_zastosowania.tex 03_aksjomatyka.tex 04_warunkowe.tex 05_zmienne.tex 06_momenty.tex 07_rozklady.tex 08_montecarlo.tex 09_ciagle.tex 10_korelacja.tex 11_ciagi.tex cwiczenia.tex 12_procesy.tex 13_lancuchy_markowa.tex 14_proces_poissona.tex 15_prng.tex 16_statystyka.tex cwiczenia.tex dowody.tex
NOTES_SRC=$(shell grep -l '\\note' $(SRC))

PDF=$(SRC:%.tex=%.pdf) $(NOTES_SRC:%.tex=%_notes.pdf) cwiczenia_odp.pdf

all: $(PDF)

$(PDF): mp.cls beamercolorthemePUT.sty beamerthemePUT.sty

%.pdf: %.tex
	pdflatex $^
	pdflatex $^

%_notes.pdf: %.tex
	pdflatex -jobname $(<:%.tex=%_notes) "\\def\\notatki{}\\input{$<}"
	pdflatex -jobname $(<:%.tex=%_notes) "\\def\\notatki{}\\input{$<}"

cwiczenia_odp.pdf: cwiczenia.tex
	pdflatex -jobname $(<:%.tex=%_odp) "\\def\\odp{}\\input{$<}"

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

15_prng.pdf: 15_prng/lcg_mod_17_hist.pdf

15_prng/lcg_mod_17_hist.pdf: 15_prng/lcg.py
	chmod +x ./15_prng/lcg.py
	(cd 15_prng; ./lcg.py)

%.image.pdf: %.image.tex %.tex
	pdflatex -output-directory "$(dir $@)" "$<"

%.png: %.image.pdf
	chmod +x convert.sh
	./convert.sh "$^" "$@"
	touch "$@"	#moze byc tak, ze powstana pliki %-liczba.png, ale wtedy i tak chcemy miec plik %.png, zeby make nie wariowalo

12_procesy.pdf: 12_procesy/thinx.tex 12_procesy/mean.png 12_procesy/corr.png

%.tex: %.pe
	chmod +x $^
	./$^ >$@

12_procesy/thinx.tex 12_procesy/mean.tex 12_procesy/corr.tex: 12_procesy/thinx.pe 12_procesy/thinx-weekly.csv
	chmod +x ./12_procesy/thinx.pe
	./12_procesy/thinx.pe <12_procesy/thinx-weekly.csv 12_procesy/thinx.tex 12_procesy/mean.tex 12_procesy/corr.tex

index.html: gen_index.pe Makefile $(SRC)
	chmod +x gen_index.pe
	./gen_index.pe $(SRC) >$@

publish: $(PDF) index.html
	rsync $(PDF) index.html libra.cs.put.poznan.pl:public_html/mp/

.PHONY: all clean publish
