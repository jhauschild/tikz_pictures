
SUBDIRS=$(sort $(dir $(wildcard ./*/Makefile)))

.PHONY: all main clean distclean


.PHONY: $(TOPTARGETS) $(SUBDIRS)


all: main $(SUBDIRS)

main: main_article.pdf

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

%.pdf: %.tex
	pdflatex -shell-escape $<
	-rm -f %.log %.aux %.auxlock %.out %.sta

clean: $(SUBDIRS)
	-rm -rf cache
	-rm -f *.log *.aux *.auxlock *.out *.sta

distclean: clean $(SUBDIRS)
	-rm -f *.pdf
