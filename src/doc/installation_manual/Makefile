all:
	make ../../INSTALL.pdf
	make ../../INSTALL.html

../../INSTALL.pdf: ../../INSTALL
	rst2latex --stylesheet=stylesheet.tex --strict $< ./INSTALL.tex && \
	pdflatex ./INSTALL.tex && \
	rm -f $@ && \
	mv ./INSTALL.pdf $@
	rm -f ./INSTALL.*

../../INSTALL.html: ../../INSTALL
	rst2html --stylesheet-path=voidspace.css -v $< $@ -r 1