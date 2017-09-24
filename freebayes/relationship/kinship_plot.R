#!/bin/Rscript
#Tychele N. Turner, Ph.D.
#Kinship plot to quickly check relationships

ibs0 <- list.files(".", pattern="ibs0")
ibsfiles <- list()
for(i in 1:length(ibs0)){
    ibsfiles[[i]] <- read.delim(ibs0[i])
}

infile <- do.call("rbind", ibsfiles)

infile$sample1Fam <- apply(infile, 1, function(x) strsplit(x[1], "\\.")[[1]][1])
infile$sample2Fam <- apply(infile, 1, function(x) strsplit(x[3], "\\.")[[1]][1])

infile$sample1Rel <- apply(infile, 1, function(x) strsplit(x[2], "\\.")[[1]][2])
infile$sample2Rel <- apply(infile, 1, function(x) strsplit(x[4], "\\.")[[1]][2])

infile$composite <- paste(infile$sample1Rel, infile$sample2Rel, sep="_")
infile <- infile[which(infile$sample1Fam == infile$sample2Fam),]

infile$exp <- apply(infile, 1, function(x) if(x[20] %in% c("fa_mo", "mo_fa")) x[ncol(x)+1] <- 0 else x[ncol(x)+1] <- 0.25)

pdf("relationship_testing.pdf", width=7, height=6)
plot(infile$exp, infile$Kinship, ylim=c(-0.3,0.5), xlab="Expected Kinship", ylab="Observed Kinship")
abline(h=0.0625, lty=3, lwd=0.5)
abline(h=0.125, lty=3, lwd=0.5)
abline(h=0.25, lty=3, lwd=0.5)
abline(h=0.5, lty=3, lwd=0.5)
dev.off()

#summary table
summary(infile$Kinship)
write.table(infile, file="summary_files.txt", sep="\t", quote=F, row.names=F)

