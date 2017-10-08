#$ -S /bin/sh
#!/bin/bash

PROBES="$1"
RPKM_DIR="$2"
CONIFER="$3"

module load modules modules-init modules-gs
module load python/2.7.2
module load hdf5/1.8.3
module load pytables/2.3.1_hdf5-1.8.3
module load numpy/1.6.1

mkdir -p ./export_svdzrpkm/
mkdir -p ./call_imgs/

python "$CONIFER" analyze --probes "$PROBES" --rpkm_dir "$RPKM_DIR" --output conifer.hdf5 --plot_scree conifer.png --svd 3

python "$CONIFER" call --input conifer.hdf5 --output conifer.txt

python "$CONIFER" export --input conifer.hdf5 --output ./export_svdzrpkm/

python "$CONIFER" plotcalls --input conifer.hdf5 --calls conifer.txt --outputdir ./call_imgs/

