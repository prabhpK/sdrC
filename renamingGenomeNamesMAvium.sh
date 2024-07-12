#!/bin/bash

#the purpose of this script is to rename the ncbi_datasets .fna files in data in the #downloadedMAviumGenomes folder to be just the number names.fna
#Enviornment: NCBI_sdrCDatabases

workFolder=/Users/charanjeetdhillon/Documents/MAvium/downloadedMAviumGenomes/ncbi_dataset/data

mkdir /Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes 

#* = list everything. Extension after tells to list anything after it
for a in $workFolder/*; do

#go through and find all .fna files and delete anything but ID of genome

#this is what each folder is called with the file in it
folderName=$(basename $a)

#iterate through file in each folder
for i in $a/*; do
fileName=$i

#echo /Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes/$folderName".fna"

#move the file to a new folder and add .fna at the end
mv $fileName /Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes/$folderName".fna"

done
done


