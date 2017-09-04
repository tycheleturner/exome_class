#$ -S /bin/sh
#!/bin/bash

SRR="$1"

module load modules modules-init modules-gs
module load ncbi-sra/latest
module load ncbi-sdk/latest
module load ncbi-vdb/latest
module load aspera/latest

prefetch -X 100G "$SRR"

