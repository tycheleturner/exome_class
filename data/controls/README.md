We needed control exome bams for Agilent V5 to run with CoNIFER and XHMM so looked in the public SRA.

1. Went to https://www.ncbi.nlm.nih.gov/sra

2. Entered the following text in the search: agilent V5 control 

3. Picked the following options
	Access: Public
	Source: DNA
	Type: exome
	Other: aligned data

4. There were 262 SRA meeting this criteria so clicked: Send results to Run selector

5. Downloaded the accession list and saved as: control_sras.txt

6. Downloaded the runinfo table and saved as: control_run_info.txt

7. Download the first 25 SRR files as follows: 
head -35 control_sras.txt  > control_sras_35.txt
sh submit_get_downloads.sh


