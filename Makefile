all: report.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.html

words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
	
histogram.tsv: histogram.r words.txt histogram.png
	Rscript $<

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(length, freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

report.html: report.Rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY: