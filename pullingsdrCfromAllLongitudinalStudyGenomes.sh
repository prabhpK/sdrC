#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

inputpath=/Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy/

for a in $inputpath*; do 
	faaname=$a
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $faaname -dbtype prot -out $extensionless

blastp -query /Users/charanjeetdhillon/Documents/MAvium/sdrCREF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore" -max_target_seqs 1



done