#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium


export CHECKM_DATA_PATH=/Users/charanjeetdhillon/Documents/MAvium/checkm_data_2015_01_16

#want to find single nucleotide similarities of genomes and use to subset and create a smaller tree
binfolder=/Users/charanjeetdhillon/Documents/MAvium/NCBIgenomesandLG_unannotated
outputfolder=/Users/charanjeetdhillon/Documents/MAvium/checkM_NCBIandLGStudy


#run each line one below one at a time:

#checkm taxon_list 
#checkm taxon_set genus Mycobacterium mycobacteriumLGStudy.cs
#checkm analyze mycobacteriumLGStudy.cs $binfolder $outputfolder
#checkm qa mycobacteriumLGStudy.cs $outputfolder > checkmoutput.txt

