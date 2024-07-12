#!/bin/bash
# Prabh Kaur 
# What this script is for: for the assembly of the whole M. Avium genome.

conda activate AssemblyEnvironment
#shovill --outdir /Users/charanjeetdhillon/Documents/MAvium/shovillOutputs/SRR13786006 --R1 /Users/charanjeetdhillon/Documents/MAvium/trimmedReads/SRR13786006paired_1.fastq --R2 /Users/charanjeetdhillon/Documents/MAvium/trimmedReads/SRR13786006paired_2.fastq

#new folder for copies of the file created from outputPath
mkdir -p /Users/charanjeetdhillon/Documents/MAvium/contigs

suffix1=paired_1.fastq
suffix2=paired_2.fastq

#running in GitHub, so need full name for path
#$ calls variable
for a in /Users/charanjeetdhillon/Documents/MAvium/trimmedReads/*$suffix1 ; do
fwdread=$a
revread=${fwdread/$suffix1/$suffix2}

#want output to be 1 folder that uses both the forward and reverse reads
#want to write a folder for each pair

# get basename of file
basefname=$(basename $fwdread)

echo $basefname

#replacing suffix 1 with blank
rename=${basefname/$suffix1/""}
echo $rename

outputPath=/Users/charanjeetdhillon/Documents/MAvium/shovillOutputs/$rename

echo $outputPath

#taking in the paths to input files, and taking in output path, and then running program 
# to put output in desired location
shovill --outdir $outputPath --R1 $fwdread --R2 $revread

#add the new file into contigs
#contigPath = current path to contigs. Not copied to. Will copy to.
contigPath=$outputPath/contigs.fa

#rename is telling us which pair, fasta tells us DNA sequence is present
newPath=/Users/charanjeetdhillon/Documents/MAvium/contigs/$rename".fasta"

#copying from current path to new path
cp $contigPath $newPath
done
