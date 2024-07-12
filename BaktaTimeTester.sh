#!/bin/bash

mkdir /Users/charanjeetdhillon/Documents/MAvium/IndividualBaktaTest
cd

export BAKTA_DB=/Users/charanjeetdhillon/Documents/Databases/db

#input = the genome we are using
Input=/Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes/GCA_910593905.1.fna 
suffix=.fna


inputprefix=/Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes/
outputprefix=/Users/charanjeetdhillon/Documents/MAvium/IndividualBaktaTest/
inputsuffix=.fna
outputsuffix=""

genomeName=GCA_910593905.1.fna

#create output annotated file name with .fna
pathwfna=${genomeName/inputprefix/$outprefix}

#create output file name without .fna
newpathAnnotations=$outputprefix${pathwfna/$inputsuffix/$outputsuffix}

annotatedGenomeName=$newpathAnnotations
prefix=$(basename $annotatedGenomeName)

#echo $prefix
#echo $newpathAnnotations

#create output file path

#timing commands and running Bakta; tells how long it took it to run in hours
start=`date +%s`
bakta --genus Mycobacterium --prefix $prefix --output $newpathAnnotations $Input
end=`date +%s`
runtime=$((end-start))
echo $(runtime/3600)