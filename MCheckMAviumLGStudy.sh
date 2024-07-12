#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium


export CHECKM_DATA_PATH=/Users/charanjeetdhillon/Documents/MAvium/checkm_data_2015_01_16

#want to find single nucleotide similarities of genomes and use to subset and create a smaller tree
binfolder=/Users/charanjeetdhillon/Documents/MAvium/contigs
outputfolder=/Users/charanjeetdhillon/Documents/MAvium/checkM_LGStudy
csfile=mycobacteriumLGStudy.cs


#run each line one below one at a time:

#checkm taxon_list 
#checkm taxon_set genus Mycobacterium $csfile
#checkm analyze $csfile $binfolder -x fasta $outputfolder
checkm qa $csfile $outputfolder > checkmResults_LGStudyOnly.txt

