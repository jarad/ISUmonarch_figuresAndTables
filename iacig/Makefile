
report.pdf: robel_yearly.png robel_yearly.tex \
            daubenmire_yearly.png daubenmire_yearly2.png daubenmire.tex \
            nectar_yearly.png nectar_ratio.csv
	pdflatex report.tex

robel_yearly.png: robel.R ../ISUcolorPalette.R
	Rscript robel.R
	
robel_yearly.tex: robel.R 
	Rscript robel.R
	
	
daubenmire_yearly.png: daubenmire.R ../ISUcolorPalette.R
	Rscript daubenmire.R
	
daubenmire_yearly2.png: daubenmire.R ../ISUcolorPalette.R
	Rscript daubenmire.R
	
daubenmire.tex: daubenmire.R 
	Rscript daubenmire.R
	

nectar_yearly.png: nectar.R ../ISUcolorPalette.R
	Rscript nectar.R
	
ratio.csv: nectar.R
	Rscript nectar.R