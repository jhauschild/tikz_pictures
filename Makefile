
SUBDIRS=$(sort $(dir $(wildcard ./*/Makefile)))

.PHONY: all main clean distclean $(SUBDIRS)

all: $(SUBDIRS) main

main: main_article.pdf

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

%.pdf: %.tex $(wildcard ./*/*.pdf)
	pdflatex -shell-escape $<
	-rm -f $*.log $*.aux $*.auxlock $*.out $*.sta

main_article.tex: generate_main.sh
	bash generate_main.sh

clean: $(SUBDIRS)
	-rm -rf cache
	-rm -f *.incl *.log *.aux *.auxlock *.out *.sta

distclean: clean $(SUBDIRS)
	-rm -f *.pdf $(SUBDIRINCL)
