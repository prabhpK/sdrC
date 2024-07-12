#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium



for a in /Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles_LongitudinalStudy/*; do 

faaname=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles_LongitudinalStudy/SRR14746715/SRR14746715.faa
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $faaname -dbtype prot -out $extensionless

#6 = make tsv
#qseqid = query id
#qcov = percentage of same characters/
#-max_target_seqs 1 means take the top one for each one
#qcovs > pident percentage. qcovs = shows 
#qcov means that both genes have the same length. tells what percentage length of query is covered by alignment
#pident shows how much of query is in the alignment

blastp -query /Users/charanjeetdhillon/Documents/MAvium/sdrCREF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore" -max_target_seqs 1
done

