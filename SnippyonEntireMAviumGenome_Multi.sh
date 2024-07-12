#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium

reference=/Users/charanjeetdhillon/Documents/MAvium/reference_sequences+training_files/REF_pt101.fasta

snippyInputPath=

snippy-multi $snippyInputPath --ref $reference --cpus 16 > runSnippy.sh

