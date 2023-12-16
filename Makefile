TESTFOLDER=tests

all: main/main
all: boxes

main/main:
	# This should be done via latexmk, but it's misbahving atm
	# latexmk $(LATEXMKSWITCHES) $@.tex
	pdflatex --output-directory main main.tex
	cp main/main.pdf pdfs/main.pdf
	# Update current number of pages in README.md
	# A=$$(pdfinfo main.pdf | awk '/^Pages:/ {print $$2}'); \
	# sed -i "s/Current.*/Current number of pages: $$A./g" README.md
bookpartial:
	latexmk $(LATEXMKSWITCHES) -pretex="\def\all{1}" $@.tex
boxes:
	latexmk $(LATEXMKSWITCHES) -jobname=$(TESTFOLDER)/$@ $(TESTFOLDER)/$@.tex

force:
	$(MAKE) LATEXMKSWITCHES=-gg all

clean:
	$(MAKE) LATEXMKSWITCHES=-C all

.PHONY: all bookmain boxes clean force
