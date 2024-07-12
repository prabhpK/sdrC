#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium

#files that we are running snippy on

#using Snippy to find the mutations across genomes, and using to find conserved regions
#usage is to later make trees

mkdir -p /Users/charanjeetdhillon/Documents/MAvium/SnippyFiles/

inputFile=/Users/charanjeetdhillon/Documents/MAvium/sdrCSeqforAnnot
#making file name
outputFile=/Users/charanjeetdhillon/Documents/MAvium/SnippyFiles/SnippyInput.tab

#making empty file for for loop to + too
touch $outputFile

#/* = go into folder and look at all its contents. 
#makes tabular input file

for file in /Users/charanjeetdhillon/Documents/MAvium/contigs/* ; do
	justID=$(basename $file)
	justID=${justID/".fasta"/""}
	printf $justID'\t'$file'\n' >> $outputFile
done
