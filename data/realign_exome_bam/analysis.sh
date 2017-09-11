#!/bin/bash

sample="$1"
downsample="$2"
bamFile="$3"
threads="$4"

set -eo pipefail 

module load samblaster
module load samtools/latest
#fextract fastq
./bin/whamg -f "$bamFile" -a reference_genome/human_g1k_v37.fasta -x "$threads" -t "$downsample" | bwa-0.7.15/bwa mem -R  '@RG\tID:\'"$sample"'\tSM:'"$sample"'' -t "$threads" -p -M reference_genome/human_g1k_v37 - | samblaster | samtools sort -@ "$threads" -m 3G -O bam -T "$sample" -o "$sample".realign.bam; samtools index "$sample".realign.bam
 
samtools flagstat "$sample".realign.bam > "$sample".realign.bam.flagstat

module load java/8u25
java -Xmx4g -XX:ParallelGCThreads=1 -jar picard-tools-2.5.0/picard.jar CollectWgsMetrics REFERENCE_SEQUENCE=reference_genome/human_g1k_v37.fasta INPUT="$sample".realign.bam OUTPUT="$sample".realign.bam.wgs VALIDATION_STRINGENCY=LENIENT

