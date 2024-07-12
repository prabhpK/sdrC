#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium

#TEST
#databases for BLAST = /Users/charanjeetdhillon/Documents/Databases/pdbaa
faaname=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles/SRR13786015/SRR13786015.faa
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $fastaname -dbtype prot -out $extensionless
blastp -query REF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore"
