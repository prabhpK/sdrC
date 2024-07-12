install.packages("BiocManager")
BiocManager::install("ggtree")
install.packages("ape")
install.packages("bio3d")
BiocManager::install("ggtreeExtra")
BiocManager::install("phytools")
BiocManager::install("Biostrings")
BiocManager::install("seqinr")
BiocManager::install("ggmsa")
install.packages("gplots")
install.packages("ggplot2")
install.packages("reshape")
install.packages("ggnewscale")
installed.packages()
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

#Goal: to plot a tree with the multiple sequence alignment on it
#making the phylogentic tree
mAviumPatientTree <- ape::read.tree(file="/Users/charanjeetdhillon/Documents/MAvium/finalPhylogeneticTree/RAxML_bestTree.finalMAviumPhylogenticTree")

mAviumPatientTree

rootedMAviumPatientTree <- phytools::midpoint.root(mAviumPatientTree)

rootedMAviumPatientTree <- phytools::midpoint.root(mAviumPatientTree)

ggtree(rootedMAviumPatientTree,layout="rectangular")  + geom_tiplab()

#dataframe 
Treeplot <- ggtree(rootedMAviumPatientTree,layout="rectangular")  + geom_tiplab()

#reading in .csv to tell it which patient is which
patientAnnotations = "/Users/charanjeetdhillon/Documents/MAvium/PhylogeneticTree_PtAnnotations/PatientAnnotation.csv"
MyDataFrame <- read.csv(patientAnnotations,header=F)
MyDataFrame

colnames(MyDataFrame) = c("label", "color", "patient")
Treeplot$data

#dpyler takes everything in front of the pipe and applies the next function to it. pipe = %>%
#left_join => finds matching data frame in right data frame to left, & merges together.
Treeplot$data = Treeplot$data %>% left_join(MyDataFrame,by="label")

#for coloring, telling R that patient = factor, not number.
Treeplot$data$patient= factor(Treeplot$data$patient)
#allows you to see the actual left_join work in a table
#View(Treeplot$data)

#ggtree is the extension of ggplot. make plot and add layers to it.
Treeplot+geom_tippoint(mapping=aes(color=patient), size=4,show.legend=T)
dev.new(width=5, height=4)

#1 read through the fasta file to find all the sites of variation, and select those
#go inside the fasta file and read it
#must specify that you want it to be read by sequnir
allsdrCLongitudinalStudyGenomesMultiFasta <- "/Users/charanjeetdhillon/Documents/MAvium/Multifastas/AllLongStudySdrcSeq_MutifastawPT101_UnprunedPhyloTree.fasta"
#read in the aligned sequence file w/o weird gene sequences
alignedSeqs <- seqinr::read.fasta(file = allsdrCLongitudinalStudyGenomesMultiFasta)
#extract the reference sequence
reference <- alignedSeqs$reference
#create a list of all sites of variation, as R Studio reads .fasta file as a list of vector of chars
variationSites <- list()
#creating a vector for the positions where there is differentiation. lists = multi-dimensional. vectors = 1-D
position <- c()

#iterate through each sequence/genome in the fasta file. all sequences are same length in this case. 
for (i in 1:length(alignedSeqs[[1]])) {
  
  # Get the amino acids (or nucleotides) at this position for all sequences
  # sapply = Applies a function to elements in a list and returns the results in a vector, matrix or a list. 
  #apply functions take the function at x[i] and apply at each place in list given to it. alignedSeqs = list.
  #use lapply instead because this is a list object, not a vector object/plain array.
  column <- lapply(alignedSeqs, function(x) x[i])
  
  # Check if variation at this position by finding any column that has a unique amino acid.
  if (length(unique(column)) > 1) {
    
    # If variation, record position
    #assigning ith element to be column
    variationSites[[i]] <- column
    #adding to a vector: currentvector <- append(currentvector,newvalue)
    #assigning ith element of the posiiton adding something (list format)
    position <- append(position, i)
  }
}
# Combine the variation sites into a dataframe/array of variation ERROR
# position is lost here.
variationSites_df <- do.call(rbind.data.frame, variationSites)
variationSites_df$Position = position

#2 recognize what the reference has for that site, and what the change is/nonreference version
# array/dataframe, parse through, find differences, and create a new dataframe with differences only
# Assuming your reference sequence is the reference sequence in file
reference <- alignedSeqs$reference

# Create a dataframe/array to store differences compared to the reference
differences_df <- data.frame(Position = NULL, Reference = NULL, Variant = NULL)

# Iterate through each position with variation

for (i in 1:length(variationSites)) {
  # Check if there is a variation at this position
  if (!is.null(variationSites[[i]])) {
    # Get the reference amino acid (or nucleotide) at this position
    referenceAminoAcids <- reference[i]
    
    # Get the variant amino acids at i position for all sequences
    variantAminoAcids <- variationSites[[i]]
    
    # Iterate through each variant
    for (j in 1:length(variantAminoAcids)) {
      if (variantAminoAcids[j] !=  referenceAminoAcids) {
        # If the variant is different from the reference, record the difference
        differences_df <- rbind(differences_df, data.frame(Position = i, Reference =  referenceAminoAcids, Variant = variantAminoAcids[j]))
      }
    }
  }
}

#3 TODO:create a heat map based off those sites with variation only
#based off the new data frame, generate heat map
# Assuming you have a data frame `differences_df` with columns  'Position', 'Reference', and 'Variant'

# Count the occurrences of each variant at each position
variant_counts <- table(differences_df$Position, differences_df$Variant)

#rows = genomes, columns = positions, value = position new
#variationSites_df = data-frame
#id = position
df <- melt(variationSites_df,id = 'Position')
ggplot(df, aes(x = factor(Position), y = variable, fill = value)) +
  geom_tile()

#geom_fruit = phylogentic tree and genome plot and put together
#p + new_scale_fill() +
#geom_fruit(data=dat2, geom=geom_tile,
#          mapping=aes(y=ID, x=Sites, alpha=Abundance, fill=Sites),
#         color = "grey50", offset = 0.04,size = 0.02)
# alpha = transparency
p <- Treeplot+geom_tippoint(mapping=aes(color=patient), size=4,show.legend=T)
p + new_scale_fill() +
  geom_fruit(data=df, geom=geom_tile,
             mapping=aes(y= variable, x= factor(Position), fill=value),axis.params=list(
               axis="x",
               title = "Amino Acid Position",
               text.angle = -45,
               text.size = 2,
               line.size = 0,
               vjust = 0), 
             color = "grey50", offset = 0.25,size = 0.02) + scale_fill_manual(values=c("#5ebdd8","#fdd285","#6c5b7b", "#2d5a4b", "#d17397", "#aa4a01", "#ea6d30"))