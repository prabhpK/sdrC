#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

#all the files from this are located in /Users/charanjeetdhillon/Documents/MAvium/sdrCforNCBI_PulledwBLAST
#ran in the BLAST Environment

inputpath=/Users/charanjeetdhillon/Documents/MAvium/FAA_NCBIGenomes_annotatedwBakta/

for a in $inputpath*; do 
	faaname=$a
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $faaname -dbtype prot -out $extensionless
	echo $extensionless

blastp -query /Users/charanjeetdhillon/Documents/MAvium/reference_sequences_training_files/sdrCREF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore" -max_target_seqs 1

done