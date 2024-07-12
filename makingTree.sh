mkdir -p /Users/charanjeetdhillon/Documents/MAvium/Tree/

cleanedSnippyFileName=/Users/charanjeetdhillon/Documents/MAvium/SnippyFiles/clean.full.aln
outputFileName=MAviumPhylogeneticTree

#random starts --100, model --GTRGAMMA, seed-- 19104
raxmlHPC -s $cleanedSnippyFileName  -n $outputFileName -m GTRGAMMA -p 19104 -N 100