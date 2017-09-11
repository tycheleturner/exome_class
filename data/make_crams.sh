#!/bin/bash
mkdir -p exomes

module load modules modules-init modules-gs
module load samtools/1.4

exomeReference='/path/to/human_g1k_v37.fasta'

#ids: NIST IDs: HG002/HG003/HG004 (Son/Father/Mother)

###~~~~~~~~~~~~~~~exome~~~~~~~~~~~~~~~###
samtools view -C -T "$exomeReference" /path/to/151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup.bam -o exomes/AJfamily.p1.final.cram
samtools index exomes/AJfamily.p1.final.cram

samtools view -C -T "$exomeReference" /path/to/151002_7001448_0359_AC7F6GANXX_Sample_HG003-EEogPU_v02-KIT-Av5_TCTTCACA_L008.posiSrt.markDup.bam -o exomes/AJfamily.fa.final.cram
samtools index exomes/AJfamily.fa.final.cram

samtools view -C -T "$exomeReference" /path/to/151002_7001448_0359_AC7F6GANXX_Sample_HG004-EEogPU_v02-KIT-Av5_CCGAAGTA_L008.posiSrt.markDup.bam -o exomes/AJfamily.mo.final.cram
samtools index exomes/AJfamily.mo.final.cram

