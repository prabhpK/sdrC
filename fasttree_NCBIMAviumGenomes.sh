#!/bin/bash
# Prabh Kaur 
#/Users/charanjeetdhillon/Documents/MAvium

mkdir -p /Users/charanjeetdhillon/Documents/MAvium/FastTree_NCBIFullGenomes

input=/Users/charanjeetdhillon/Documents/MAvium/AllMAvium_core.full_cleaned.aln
output=fasttreeoutput.tree

FastTree -nt -gtr -fastest -no2nd -gamma $input > $output