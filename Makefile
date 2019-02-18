all: histogram.png

clean:
	rm -f words.txt histogram.tsv

words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
	
histogram.tsv: histogram.r words.txt histogram.png
	Rscript $<

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(length, freq, data=read.delim("$<")); ggsave("$@")'