

STANDALONE_TEX=$(wildcard */*.tex)
STANDALONE_PDF=$(STANDALONE_TEX:.tex=.pdf)

.PHONY: all clean main

all: $(STANDALONE_PDF) main

main: main_article.pdf

%.pdf: %.tex
	pdflatex -shell-escape $<

clean:
	rm -rf cache
	rm -f *.log *.aux *.auxlock *.out *.sta
	rm -f */*.log */*.aux */*.out */*.sta
