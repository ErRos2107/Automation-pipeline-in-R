words <- readLines("words.txt",n=-1)
frequency.table <- table(nchar(words))

table.name <- c("length","freq")
histogram.table <- as.data.frame(frequency.table)
colnames(histogram.table) <- table.name

write.table(histogram.table, "histogram.tsv",
            sep = "\t", row.names = FALSE, quote = FALSE)


