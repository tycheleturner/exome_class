#!/bin/Rscript
#Tychele N. Turner, Ph.D.
#Counter of variants by chromosome

library("optparse")
 
option_list <- list(
	make_option(c('-i', '--inputfile'), action='store', type='character', default='datafile.txt', help='Input datafile for getting variant counts per chromosome'),
        make_option(c('-z', '--hetfile'), action='store', type='character', default='hetfile.txt', help='Output datafile with heterozyous variant counts (0/1, 1/0) per chromosome'),
        make_option(c('-o', '--outfile'), action='store', type='character', default='outfile.txt', help='Output datafile with all variant counts (0/1, 1/0, 1/1) per chromosome')
)
opt <- parse_args(OptionParser(option_list = option_list))
 
inputfile = opt$inputfile
outfile = opt$outfile
hetfile = opt$hetfile

datafile <- read.delim(inputfile, sep="", header=F)
datafile$chrom <- apply(datafile,1, function(x) strsplit(x[2], "_")[[1]][1])
datafile$geno <- apply(datafile,1, function(x) strsplit(x[2], "_")[[1]][2])
variants <- datafile[which(datafile$geno %in% c("0/1", "1/0", "1/1")),]
agg <- aggregate(V1~chrom, data=variants, sum)
colnames(agg) <- c("Chromosome", "Number of variants")
write.table(agg, file=outfile, sep="\t", quote=F, row.names=F)

hets <- variants[which(variants$geno %in% c("0/1", "1/0")),]
agg2 <- aggregate(V1~chrom, data=hets, sum)
colnames(agg2) <- c("Chromosome", "Number of heterozygous variants")
write.table(agg2, file=hetfile, sep="\t", quote=F, row.names=F)

