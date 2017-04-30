# Taken from https://github.com/Witiko/fithesis3-bt/blob/master/Makefile
.PHONY: all clean implode

#RESOURCES=database.bib definitions.sty glossaries.tex misc/*.pdf
RESOURCES=

NONSOURCES=$(OUTPUT).pdf
OUTPUT=thesis
TEX=pdflatex -shell-escape
AUX=$(OUTPUT).aux $(OUTPUT).toc $(OUTPUT).bbl $(OUTPUT).blg \
	$(OUTPUT).ind $(OUTPUT).idx $(OUTPUT).out $(OUTPUT).gl[gos] \
	$(OUTPUT).xdy $(OUTPUT).lo[ftg] $(OUTPUT).ac[rn] $(OUTPUT).alg \
	$(OUTPUT).run.xml $(OUTPUT).bcf $(OUTPUT)-blx.bib $(OUTPUT).mw \
	$(OUTPUT).cb $(OUTPUT).cb2 $(OUTPUT).ilg texput.log

# This target typesets the printed version of
# the thesis and removes the auxiliary files.
all:
	make $(OUTPUT).pdf clean

# This target typesets the thesis.
$(OUTPUT).pdf: $(OUTPUT).tex $(RESOURCES)
	#@toolbox/test.sh pdflatex texindy biber makeglossaries
	#pdflatex texindy biber makeglossaries
	$(TEX) $<
	$(TEX) $<
	# Prepare index, bibliography and glossaries
	#texindy -I latex -C utf8 -L english $(OUTPUT).idx
	#makeglossaries $(OUTPUT)
	#$(TEX) $<
	#biber $(OUTPUT)
	bibtex $(OUTPUT).aux
	#makeglossaries $(OUTPUT)
	$(TEX) $<
	$(TEX) $<

# This target removes auxiliary files.
clean:
	rm -f $(AUX)

# This target removes all non-source files.
implode: clean
	rm -f $(NONSOURCES)
