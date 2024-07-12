#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium

reference=/Users/charanjeetdhillon/Documents/MAvium/ncbi_dataset/ncbi_dataset/data/GCA_001865635.4/GCA_001865635.4_ASM186563v4_genomic.fasta 
snippyInputPath=/Users/charanjeetdhillon/Documents/MAvium/SnippyFiles/SnippyInput.tab 
snippy-multi $snippyInputPath --ref $reference --cpus 16 > runSnippy.sh

