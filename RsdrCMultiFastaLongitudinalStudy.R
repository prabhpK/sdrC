install.packages("protr")
install.packages("lapply")
install.packages("readr")
library("readr")
library("lapply")
library("protr")
library("seqinr")
library("parallel")
library("gplots")
library("ggplot2")
library("ggnewscale")
library("reshape")
library("ape")
library("phytools")
library("ggtree")
library("dplyr")
library("seqinr")
library("Biostrings")
library("bio3d")
library("ggmsa")
library("ggtreeExtra")

#Purpose: I have the FAA_AnnotatedFiles_LongitudinalStudy folder in which all the annotated sequence files are located
#In the sdrCforLongitudinalStudy_PulledwBLAST folder there are the ids of all the sdrC names in each of the sequences in the .tab files
#I want to extract all the sdrC sequences from the .faa files using the corresponding .tab
#then, I want to take all the sdrC sequences from the individual strains, and put them into a multifasta file with the strain name, and then the id of the sequence

files = list.files("/Users/charanjeetdhillon/Documents/MAvium/sdrCforLongitudinalStudy_PulledwBLAST")
for(filename in files){
  print(filename)
}

#list of all .tab file names
tab_files<-
list.files ("/Users/charanjeetdhillon/Documents/MAvium/sdrCforLongitudinalStudy_PulledwBLAST", "*.tab", full.names = TRUE)
tablist <- list(tab_files)
print(tab_files)
print(tablist)

#list of all .faa file names
faa_files <- list.files("/Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy", "*.faa", full.names = TRUE)
faalist <- list(faa_files)
print(faa_files_fldr)

#iterate through all of the tab files

seq_MultiFast <- list()


for (i in tab_files) {
  #print(i)
  #read each table file
  #separater is set to tab here
  sdrCinfotable <- read.csv2(i, sep="\t",header=F)
  #print(sdrCinfotable)
  #set a for loop for if the V3 or V7 is less than 80, do not use this sequence ID based off the table made from reading the tab file
  #accessing a column in dataframe use $
  if (as.numeric(as.character(sdrCinfotable$V3)) >= 80 && as.numeric(as.character(sdrCinfotable$V7)) >= 80) {
    #take the basename of the .tab file, and find corresponding basename .faa file
    basename_wtab = basename(i)
    IDName <- sdrCinfotable$V2
    strainName = gsub(basename_wtab, pattern=".tab", replacement="")
    strainName2 = gsub(strainName, pattern=".tsv", replacement="")
    newFileEnding = gsub(i, pattern=".tab", replacement=".faa")
    newFileEndingTSV = gsub(newFileEnding, pattern=".tsv", replacement="")
    #paste0 = concatenate
    pathForFaa = paste0("/Users/charanjeetdhillon/Documents/MAvium/FAA_AnnotatedFiles_LongitudinalStudy/", strainName2,".faa")
    faaReading <- seqinr::read.fasta(file = pathForFaa)
    #actual sequence for the gene
    sequenceForsdrCID <- faaReading[IDName]
    fullName = paste0(strainName2,"_",IDName)
        
    #setting the sequence equal to it's full name
    seq_MultiFast[fullName] = sequenceForsdrCID

  }else{
      print(paste0("SdrC not in ",strainName2 ))
      print(sdrCinfotable$V3 )
      print(sdrCinfotable$V7)
  }
}