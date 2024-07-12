#install.packages("protr")
#install.packages("lapply")
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

files = list.files("/Users/charanjeetdhillon/Documents/MAvium/sdrCforNCBI_PulledwBLAST")

#list of all .tab file names
tab_files<-list.files ("//Users/charanjeetdhillon/Documents/MAvium/sdrCforNCBI_PulledwBLAST", "*.tab", full.names = TRUE)
tablist <- list(tab_files)

#list of all .faa file names
faa_files <- list.files("/Users/charanjeetdhillon/Documents/MAvium/FAA_NCBIGenomes_annotatedwBakta/", "*.faa", full.names = TRUE)
faalist <- list(faa_files)

#iterate through all of the tab files

seq_MultiFast <- list()


for (i in tab_files) {
  sdrCinfotable <- read.csv2(i, sep="\t",header=F)
  basename_wtab = basename(i)
  IDName <- sdrCinfotable$V2
  strainName = gsub(basename_wtab, pattern=".tab", replacement="")
  strainName2 = gsub(strainName, pattern=".tsv", replacement="")
  newFileEnding = gsub(i, pattern=".tab", replacement=".faa")
  newFileEndingTSV = gsub(newFileEnding, pattern=".tsv", replacement="")
  if (as.numeric(as.character(sdrCinfotable$V3)) >= 80 && as.numeric(as.character(sdrCinfotable$V7)) >= 80) {
    pathForFaa = paste0("/Users/charanjeetdhillon/Documents/MAvium/FAA_NCBIGenomes_annotatedwBakta/", strainName2,".faa")
    faaReading <- seqinr::read.fasta(file = pathForFaa)
    sequenceForsdrCID <- faaReading[IDName]
    fullName = paste0(strainName2,"_",IDName)
    seq_MultiFast[fullName] = sequenceForsdrCID
    
  }else{
    print(paste0("SdrC not in ",strainName2 ))
    print(sdrCinfotable$V3 )
    print(sdrCinfotable$V7)
  }
}
seqinr::write.fasta(sequences = seq_MultiFast, names = names(seq_MultiFast), file.out = "/Users/charanjeetdhillon/Documents/MAvium/multifastaFileForNCBIGenomes_7.1")


