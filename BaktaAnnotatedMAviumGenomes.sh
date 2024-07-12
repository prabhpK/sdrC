#!/bin/bash
#intent of script is to annotate all 444 of the NCBI M. Avium genomes

export BAKTA_DB=/Users/charanjeetdhillon/Documents/Databases/db

mkdir /Users/charanjeetdhillon/Documents/MAvium/AnnotatedNCBIgenomes

inputprefix=/Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes/
outputprefix=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedNCBIgenomes/

inputsuffix=.fna
outputsuffix=""

output1=AnnotatedNCBIgenomes/GCA_910593905.1
output2=AnnotatedNCBIgenomes/GCA_910593945.1

suffix=.fasta

For a in $inputprefix*.fna ; do
genomeName=$a
pathwfna=${genomeName/$inputprefix/$outputprefix}
newpathAnnotations=$outputprefix${pathwfna/$inputsuffix/$outputsuffix}
annotatedGenomeName=$newpathAnnotations
prefix=$(basename $annotatedGenomeName)

bakta --genus Mycobacterium --prefix $prefix --output $newpathAnnotations $a

done