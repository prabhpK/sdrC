#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

mkdir -p /Users/charanjeetdhillon/Documents/MAvium/sdrCTree_pt101ref_study+NCBI_EntireGenomes/

multifastaWithsdrC_refpt101=/Users/charanjeetdhillon/Documents/MAvium/Multifastas/AllLongStudySdrCSeq_MutifastawPT101.fasta

raxmlHPC -s $cleanedSnippyFileName  -n $outputFileName -m GTRGAMMA -p 19104 -N 100