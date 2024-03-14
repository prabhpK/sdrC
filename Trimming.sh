# trimmomatic PE rawReads/SRR14746715_1.fastq rawReads/SRR14746715_2.fastq 
#figuring out what parts are not good quality and adaptors to cut out

input1=rawReads/SRR14746715_1.fastq
input2=rawReads/SRR14746715_2.fastq

outputpaired1=trimmedReads/SRR14746715paired_1.fastq
outputpaired2=trimmedReads/SRR14746715paired_2.fastq

outputunpaired1=trimmedReads/SRR14746715unpaired_1.fastq
outputunpaired2=trimmedReads/SRR14746715unpaired_2.fastq

#calling the value of input1 variable
#trimmomatic PE -phred33 $input1 $input2 $outputpaired1 $outputunpaired1 $outputpaired2 $outputunpaired2 ILLUMINACLIP:trimmomatic_nextera_adapters.fa:2:40:15


suffix1=_1.fastq
suffix2=_2.fastq
suffixpaired1=paired_1.fastq
suffixpaired2=paired_2.fastq
suffixunpared1=unpaired_1.fastq
suffixunpared2=unpaired_2.fastq

prefixinput=rawReads/
prefixoutput=trimmedReads/

for a in rawReads/*_1.fastq ; do

#value of forward read (path to frwd read)
fwdread=$a

#replacing suffixes to get reverse read path
revread=${fwdread/$suffix1/$suffix2}

#creating outputs 
output1fwrd=${fwdread/$prefixinput/$prefixoutput}
output2rev=${revread/$prefixinput/$prefixoutput}

outpaired1=${output1fwrd/$suffix1/$suffixpaired1}
outpaired2=${output2rev/$suffix2/$suffixpaired2}

outunpaired1frwd=${output1fwrd/$suffix1/$suffixunpared1}
outunpaired2rev=${output2rev/$suffix2/$suffixunpared2}

#echo $fwdread
#echo $revread
#echo $outpaired1
#echo $outpaired2
#echo $outunpaired1frwd
#echo $outunpaired2rev

trimmomatic PE -phred33 $fwdread $revread $outpaired1 $outunpaired1frwd $outpaired2 $outunpaired2rev ILLUMINACLIP:trimmomatic_nextera_adapters.fa:2:40:15 HEADCROP:15 
done


