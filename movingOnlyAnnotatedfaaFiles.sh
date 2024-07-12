#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

#where I want my new files to go
mkdir -p /Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy/

#the name of the directory, where I want to go through each folder and find .faa files from
inputprefix=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles_LongitudinalStudy/
#the folder where I want the .faa files to go
outputprefix=/Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy/

suffix=.faa

#go through each folder and look at files
for a in $inputprefix*; do 

filename=$(basename $a)
faafile=$filename$suffix
faapath=$a/$faafile

newpathoffile=$outputprefix/$faafile
cp $faapath $newpathoffile

done