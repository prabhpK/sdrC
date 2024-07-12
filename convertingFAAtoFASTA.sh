#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

#where I want my new files to go
mkdir -p /Users/charanjeetdhillon/Documents/MAvium/FASTA_AnnotatedFiles_LongitudinalStudy/

#the name of the directory, where I want to go through each folder and find .faa files from
inputprefix=/Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy
#the folder where I want the .faa files to go
outputprefix=/Users/charanjeetdhillon/Documents/MAvium/FASTA_AnnotatedFiles_LongitudinalStudy/

suffix=.faa
suffixnew=.fasta


#go through each folder and look at files
for a in $inputprefix*; do 

filename=$(basename $a)
faafile=$filename$suffix
faapath=$a/$faafile

echo $faafile
echo $faapath

rename=${faafile/$suffix/""}

newpathoffile=$outputprefix/$rename".fasta"

cp $faapath $newpathoffile

done