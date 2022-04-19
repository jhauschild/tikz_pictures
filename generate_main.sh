#!/bin/bash

SUBDIRS=$(find * -type d)  # exclude .git !

{
	echo '
\documentclass{article}
% \usepackage[subpreambles,sort]{standalone}
% \usepackage{tikz}
% \usetikzlibrary{external}
% \tikzexternalize[prefix=cache/]
\usepackage{graphicx}

\begin{document}
'
	for DIR in $SUBDIRS
	do
		FILES=$(grep -l "documentclass.*standalone" $DIR/*.tex)
		echo "	\\section{$DIR}" | sed -r 's/_/\\_/g'
		for F in $FILES
		do
			# echo "		\\begin{figure}"
			echo "		\\subsection{$F}" | sed -r 's/_/\\_/g'
			echo "		\\includegraphics{${F%.tex}.pdf}"
			# echo "		\\end{figure}"
		done
	done
	echo '
\end{document}
'
} > main_article.tex
