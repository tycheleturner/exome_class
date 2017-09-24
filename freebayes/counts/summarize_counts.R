#!/bin/Rscript
#Tychele Turner, Ph.D.
#Test counts per chromosome in FreeBayes data

pdf("counts_per_person.pdf", width=11, height=8.5)

###FreeBayes
infiles <- list.files(".", pattern="*.freebayes.variants.counts.per.chrom.ct*")
counts <- list()
for(i in 1:length(infiles)){
        counts[[i]] <- read.delim(infiles[i])
        counts[[i]] <- counts[[i]][which(counts[[i]]$Chromosome != "MT"),]
	counts[[i]] <- counts[[i]][which(counts[[i]]$Chromosome %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")),]
        counts[[i]]$sample <- sapply(infiles, function(x) strsplit(x, ".free")[[1]][1])[i]
}
comb <- do.call("rbind", counts)
comb <- comb[which(comb$Chromosome != "MT"),]
comb <- comb[which(comb$Chromosome %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")),]
comb$Chromosome <- factor(comb$Chromosome, levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y"))
boxplot(Number.of.variants~Chromosome, data=comb, col="blue", cex.axis=0.7, xlab="chromosome", ylab="number of variants")
write.table(comb, file="combined.freebayes.counts.across.samples.tsv", sep="\t", quote=F, row.names=F)

numberOfChromsWithVariants <- list()
for(i in 1:length(counts)){
        numberOfChromsWithVariants[[i]] <- nrow(counts[[i]][which(counts[[i]]$Number.of.variants > 0),])
}
table(unlist(numberOfChromsWithVariants))

###FreeBayes hets
infiles <- list.files(".", pattern="*.freebayes.heterozygous.variants.counts.per.chrom.hct*")
counts <- list()
for(i in 1:length(infiles)){
        counts[[i]] <- read.delim(infiles[i])
        counts[[i]] <- counts[[i]][which(counts[[i]]$Chromosome != "MT"),]
        counts[[i]] <- counts[[i]][which(counts[[i]]$Chromosome %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")),]
        counts[[i]]$sample <- sapply(infiles, function(x) strsplit(x, ".free")[[1]][1])[i]
}
comb <- do.call("rbind", counts)
comb <- comb[which(comb$Chromosome != "MT"),]
comb <- comb[which(comb$Chromosome %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y")),]
comb$Chromosome <- factor(comb$Chromosome, levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y"))
boxplot(Number.of.heterozygous.variants~Chromosome, data=comb, add=T, col="springgreen", cex.axis=0.7)
write.table(comb, file="combined.freebayes.heterozygous.counts.across.samples.tsv", sep="\t", quote=F, row.names=F)

numberOfChromsWithVariants <- list()
for(i in 1:length(counts)){
        numberOfChromsWithVariants[[i]] <- nrow(counts[[i]][which(counts[[i]]$Number.of.heterozygous.variants > 0),])
}
table(unlist(numberOfChromsWithVariants))

legend("topright", fill=c("blue", "springgreen"), legend=c("FreeBayes variants", "FreeBayes heterozgous variants"))

dev.off()
