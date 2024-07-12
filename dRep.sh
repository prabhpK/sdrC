#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

#the purpose of this shell script is to figure out which genomes are closet by 'snp distance' so I can get a subset of representative genomes from the NCBI genomes as the current ones are taking too long to process


dRep dereplicate condensedMAviumGenomesList_directory --S_algorithm fastANI -g /Users/charanjeetdhillon/Documents/MAvium/NCBIgenomes_unannotated/*