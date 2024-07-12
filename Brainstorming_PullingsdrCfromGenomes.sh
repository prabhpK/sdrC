#!/bin/bash

#Goal is to go through all the M. avium genomes from GenBank and the case studies and pull sdrC gene
#for now, only trying to get it to work on M. avim genomes


#!/bin/bash
# Blast searching for promoter for crtOPQMN operon in each of the assemblies
 # Requires BlastEnv
for fastaname in /project/grice/storage/HiSeq/WGS/HiSeq_19/AssemblyFastas/DFU100_Cleaned_Assemblies/FinalContigs/*.fasta; do
        base=$(basename $fastaname)
	baseext=".fasta"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $fastaname -dbtype nucl -out $extensionless
        blastn -query xanthinpromoter.fasta -max_target_seqs 1 -out $extensionless$tabext -db $extensionless -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore"
done


#TODO: run on one to see what output file looks like & open output file in textEdit. have to download BLAST in command line, in condo
#MY CODE: 
for faaname in /Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles/*.faa; do
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $fastaname -dbtype nucl -out $extensionless
blastp -query /Users/charanjeetdhillon/Documents/MAvium/REF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore"

done
#TEST
faaname=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles/SRR13786015/SRR13786015.faa
        base=$(basename $faaname)
	baseext=".faa"
	blank=""
	extensionless=${base/$baseext/$blank}
	tabext=".tab"
	makeblastdb -in $fastaname -dbtype nucl -out $extensionless
blastp -query /Users/charanjeetdhillon/Documents/MAvium/REF_pt101.fasta -db $extensionless -out $extensionless$tabext -outfmt "6 qseqid sseqid pident length sstart send qcovs evalue bitscore"
