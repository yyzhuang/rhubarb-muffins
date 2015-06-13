all:

cleanall:
	rm -f *.ps.gz *.ps *.pdf *.dvi *.aux *.log *.blg *.bbl

%.ps.gz:%.ps
	gzip -c $(@:.ps.gz=.ps) > $(@)

%.txt:  %.pdf
	pdftotext -raw $(@:.txt=.pdf)

%.pdf:	%.ps
	ps2pdf $(@:.pdf=.ps)

%.Pdf:
	latex $(@:.Pdf=.tex); latex $(@:.Pdf=.tex)
	rm -f $(@:.Pdf=.log) $(@:.Pdf=.aux)
	dvips $(@:.Pdf=.dvi) -o -t letter -Ppdf -G0 -e 0
	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $(@:.Pdf=.ps)
	pdffonts $(@:.Pdf=.pdf)

%.PDF:  %.ps
	latex $(@:.PDF=.tex); bibtex $(@:.PDF=)
	latex $(@:.PDF=.tex); latex $(@:.PDF=.tex)
	rm -f $(@:.PDF=.log) 
	dvips $(@:.PDF=.dvi) -o -t letter -Ppdf -G0 -e 0
	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $(@:.PDF=.ps)

%.ps:	%.dvi
	dvips $(@:.ps=.dvi) -o -t letter -Ppdf -G0 -e 0

%.dvi:	%.tex
	latex $(@:.dvi=.tex); latex $(@:.dvi=.tex)
	rm -f $(@:.dvi=.log) $(@:.dvi=.aux)

