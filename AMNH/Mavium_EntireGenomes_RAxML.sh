#!/bin/bash
#PBS -V
#PBS -q batch
#PBS -S /bin/bash
#PBS -N Mavium_EntireGenomes_RAxML
#PBS -l select=1:ncpus=64
#PBS -l walltime=240:00:00

mkdir -p /home/pkaur/nas1/MAviumTree/PreClonalFrameMl

cleanedSnippyFile=/home/pkaur/nas1/MAviumTree/fullGenomes_Mavium.aln
outputFileName= PreClonalFrameMl

#-p is the random seed. run same command everytime, has same result anytime
raxmlHPC -s $cleanedSnippyFile  -n $outputFileName -m GTRCAT -p 19104 -N 10
