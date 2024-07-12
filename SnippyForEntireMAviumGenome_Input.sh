#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium
#ran on Dr. Amy's laptop

mkdir -p /scr1/users/campbela12/Mycobacterium/SnippyFiles_NCBI+LGStudy/

inputFile=/scr1/users/campbela12/Mycobacterium/MAviumGenomesTree

#making file name
outputFile=/scr1/users/campbela12/Mycobacterium/SnippyFiles_NCBI+LGStudy/SnippyInputAllGenomes.tab

#making empty file for for loop to + too
touch $outputFile

#/* = go into folder and look at all its contents. 
#makes tabular input file

for file in $inputFile/* ; do
	justID=$(basename $file)
	justID=${justID/".fasta"/""}
	printf $justID'\t'$file'\n' >> $outputFile
done
