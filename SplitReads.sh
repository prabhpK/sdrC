#!/bin/bash
# Prabh Kaur 
# What this script is for: splitting fastQ SRA reads into forward and reverse reads. (paired ends sequencing)

# fastq-dump --split-files SRR13786015

#creating an array with all files
myArray=('SRR14736605' 'SRR14736603' 'SRR14736598' 'SRR14736595' 'SRR14736596' 'SRR14736597' 'SRR14736599' 
'SRR14736601' 'SRR13786006' 'SRR14736592' 'SRR14736594' 'SRR14746709' 'SRR14746715' 'SRR14746704' 'SRR14746703' 
'SRR14746706')


for a in "${myArray[@]}" ; do

fastq-dump --split-files $a
echo $a 


done
