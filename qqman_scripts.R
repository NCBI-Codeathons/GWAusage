#Instal packages
install.packages("qqman")
library(qqman)

#Read table
results<-read.table(".mlma",header=True)

#Create manhattan plot
manplot<-manhattan(results, chr = Chr, bp = "bp", p = 'p', snp ="SNP")
pdf("manhattan.pdf")
manplot
dev.off()

#Create Q-Q plot
qqplot<-qq(results$p)
pdf("qqplot.pdf")
qqplot
dev.off()

#Print plots
manplot
qqplot