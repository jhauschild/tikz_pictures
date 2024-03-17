
SUBDIRS=$(sort $(dir $(wildcard ./*/Makefile)))
SUBDIRTEXS=$(filter-out $(wildcard ./*/tikzlibrarytensornetwork.code.tex), $(wildcard ./*/*.tex))
SUBDIRPDFS=$(SUBDIRTEXS:.tex=.pdf)

.PHONY: all main clean distclean $(SUBDIRS)

all: $(SUBDIRS) main

main: main_article.pdf example_MPS.png

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

$(SUBDIRPDFS):
	$(MAKE) -C $(dir $@) $(notdir $@)

%.pdf: %.tex $(SUBDIRPDFS)
	pdflatex -shell-escape $<
	pdflatex -shell-escape $<
	-rm -f $*.log $*.aux $*.auxlock $*.out $*.sta $*.toc

main_article.tex: generate_main.sh $(SUBDIRTEXS)
	bash generate_main.sh

example_MPS.png : example_MPS.pdf
	pdftoppm -scale-to 800 $< -png > $@

clean: $(SUBDIRS)
	-rm -rf cache
	-rm -f *.incl *.log *.aux *.auxlock *.out *.sta *.toc *.fls *.fdb_latexmk *.synctex.gz

distclean: clean $(SUBDIRS)
	-rm -f *.pdf
