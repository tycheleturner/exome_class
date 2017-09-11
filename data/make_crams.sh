#!/bin/bash
mkdir -p exomes

module load modules modules-init modules-gs
module load samtools/1.4

exomeReference='/path/to/human_g1k_v37.fasta'

#ids: NIST IDs: HG002/HG003/HG004 (Son/Father/Mother)

###~~~~~~~~~~~~~~~exome~~~~~~~~~~~~~~~###
samtools view -C -T "$exomeReference" ../realign_exome_bam/AJfamily.p1.realign.bam -o exomes/AJfamily.p1.final.cram
samtools index exomes/AJfamily.p1.final.cram

samtools view -C -T "$exomeReference" ../realign_exome_bam/AJfamily.fa.realign.bam -o exomes/AJfamily.fa.final.cram
samtools index exomes/AJfamily.fa.final.cram

samtools view -C -T "$exomeReference" ../realign_exome_bam/AJfamily.mo.realign.bam -o exomes/AJfamily.mo.final.cram
samtools index exomes/AJfamily.mo.final.cram

