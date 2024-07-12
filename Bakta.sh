#!/bin/bash
# Prabh Kaur 
# /Users/charanjeetdhillon/Documents/MAvium


#annotating the contigs
#using Bakta to annotate 

#setting way to easily call Bakta using its file pathway
#w/o export doesn't remember path
export BAKTA_DB=/Users/charanjeetdhillon/Documents/Databases/db
#bakta /Users/charanjeetdhillon/Documents/MAvium/contigs

#do for loop. Output 

mkdir -p /Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles_LongitudinalStudy/


input1=contigs/SRR14746715.fasta
input2=contigs/SRR14746709.fasta

inputsuffix=.fasta
outputsuffix="" 

output1=AnnotatedFiles/SRR14746715
output2=AnnotatedFiles/SSRR14746709

suffix=.fasta

inputprefix=/Users/charanjeetdhillon/Documents/MAvium/contigs/
outputprefix=/Users/charanjeetdhillon/Documents/MAvium/AnnotatedFiles_LongitudinalStudy/

for a in $inputprefix*.fasta ; do
	#echo $a
#used to be contigname=$a
contigname=$(basename $a)


#create output file path
newpathAnnotations=$outputprefix${contigname/$inputsuffix/$outputsuffix}

# var1=/My/absolute/path/name
# $(basename $var1)
# this will return name
contigStrainName=$newpathAnnotations
prefix=$(basename $contigStrainName)
#echo $prefix
#echo $contigStrainName

#call for one genome, only use flags if giving values, inputting the contig file, want output to be #same name w/o fast
#added following to bakta command below: --db /Users/charanjeetdhillon/Documents/Databases/db --prodigal-tf /Users/charanjeetdhillon/Documents/MAvium/prodigalTrainingFile_pt101.trn
bakta --db /Users/charanjeetdhillon/Documents/Databases/db --prodigal-tf /Users/charanjeetdhillon/Documents/MAvium/prodigalTrainingFile_pt101.trn --genus Mycobacterium --prefix $prefix --output $newpathAnnotations $a 

#echo $prefix
#echo $newpathAnnotations
#echo $a

done