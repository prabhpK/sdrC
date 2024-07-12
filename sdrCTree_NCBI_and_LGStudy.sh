#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

#put the clustalWAlignmentIntotheThing, so it is spaced out and can be put together
clustalWFileName=/Users/charanjeetdhillon/Documents/MAvium/ClustalW_Alignment_Results/sdrConly_NCBIMultiFasta_NCBIandLGSTUDY_ClustalW.fasta
outputFileName=sdrCPhylogeneticTree

#random starts --100, model --GTRGAMMA, seed-- 19104
#https://cme.h-its.org/exelixis/web/software/raxml/hands_on.html
raxmlHPC -s $clustalWFileName -n $outputFileName -m PROTGAMMAAUTO -p 19104 -N 100