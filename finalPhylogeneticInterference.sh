#using RAxMLEnvironment

#remember to cd into the folder lol!
mkdir -p /Users/charanjeetdhillon/Documents/MAvium/finalPhylogeneticTree/

filteredMaskAlignment=/Users/charanjeetdhillon/Documents/MAvium/ClonalFrameMLFiles/MaskedAlignment.filtered.fasta
outputFileName=finalMAviumPhylogenticTree

#random starts --100, model --GTRGAMMA, seed-- 19104
raxmlHPC -s $filteredMaskAlignment -n $outputFileName -m GTRGAMMA -p 19104 -N 100

