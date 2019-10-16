
report.pdf: robel_yearly.png robel_yearly.tex
	pdflatex report.tex

robel_yearly.png: robel.R ../ISUcolorPalette.R
	Rscript robel.R
	
robel_yearly.tex: robel.R ../ISUcolorPalette.R
	Rscript robel.
	