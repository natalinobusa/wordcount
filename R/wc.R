#!/usr/bin/Rscript

#read in and clean
x = scan("lorem.txt", what="", sep=" ")
x.clean = gsub("\\W+","",tolower(x))
 
#word count
wc = table(x.clean)
 
#output to stdout
print(as.data.frame(wc), row.names=rep("", nrow(wc)))

