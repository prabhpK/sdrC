install.packages("dplyr")
install.packages("stringr")
library("dplyr")
library("stringr")
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

#END: DOUBLE CHECK HAS LONGITUDINAL STUDY AND NCBI WEBSITE ALL M. AVIUM SDRCS ONLY!!!
#Goal: to plot a tree with the multiple sequence alignment on it
#making the phylogentic tree
sdrCTree <- ape::read.tree(file="/Users/charanjeetdhillon/Documents/MAvium/RAxML_sdrCPhylogeneticTree/RAxML_bestTree.sdrCPhylogeneticTree")

sdrCTree

rootedsdrCTree <- phytools::midpoint.root(sdrCTree)

rootedsdrCTree <- phytools::midpoint.root(sdrCTree)

ggtree(rootedsdrCTree,layout="rectangular")  + geom_tiplab()

#dataframe 
Treeplot <- ggtree(rootedsdrCTree,layout="rectangular")  + geom_tiplab()


#dpyler takes everything in front of the pipe and applies the next function to it. pipe = %>%
#left_join => finds matching data frame in right data frame to left, & merges together.
Treeplot$data = Treeplot$data %>% left_join(MyDataFrame,by="label")

#for coloring, telling R that patient = factor, not number.
#Treeplot$data$patient= factor(Treeplot$data$patient)
#allows you to see the actual left_join work in a table
#View(Treeplot$data)

#ggtree is the extension of ggplot. make plot and add layers to it.
#Treeplot+geom_tippoint(mapping=aes(color=patient), size=4,show.legend=T)
#dev.new(width=5, height=4)
 

#...............................................................................................................
#1 read through the fasta file to find all the sites of variation, and select those
#go inside the fasta file and read it
#must specify that you want it to be read by sequnir
allsdrCLongitudinalStudyGenomesMultiFasta <- "/Users/charanjeetdhillon/Documents/MAvium/ClustalW_Alignment_Results/sdrC_NCBI_LGStudy_New_ClustalW.fasta"
alignedSeqs <- seqinr::read.fasta(file = allsdrCLongitudinalStudyGenomesMultiFasta)
reference <- alignedSeqs$reference_pt101
variationSites <- list()
position <- c()

#iterate through each sequence/genome in the fasta file. all sequences are same length in this case. 
for (i in 1:length(alignedSeqs[[1]])) {
  
  # Get the amino acids (or nucleotides) at this position for all sequences
  # sapply = Applies a function to elements in a list and returns the results in a vector, matrix or a list. 
  #apply functions take the function at x[i] and apply at each place in list given to it. alignedSeqs = list.
  #use lapply instead because this is a list object, not a vector object/plain array.
  column <- lapply(alignedSeqs, function(x) x[i])
  
  # Check if variation at this position by finding any column that has a unique amino acid.
  if (length(unique(column)) > 1 && i >= 32 && i <= 295) {
    
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

 
#based off that table, I the genomes with variants at those sites to have a specific color, and the rest to just be black that match with the reference
#getting names of protein name, however, need to be able to iterate through the file and get all protein names
pathForFasta <- "/Users/charanjeetdhillon/Documents/MAvium/ClustalW_Alignment_Results/sdrConly_NCBIMultiFasta_NCBIandLGSTUDY_ClustalW.fasta"
sdrCEntireFileandSeqs <- seqinr::read.fasta(file = pathForFasta)
library("Biostrings")
protein_name <- readAAStringSet("/Users/charanjeetdhillon/Documents/MAvium/ClustalW_Alignment_Results/sdrConly_NCBIMultiFasta_NCBIandLGSTUDY_ClustalW.fasta",use.names=TRUE)
names(protein_name[1])
#deplyr
#Table: position, reference_genomeAminoAcid, genome_Name, aminoAcidforGenome
#shared variable = position


#3 TODO:create a heat map based off those sites with variation only
#based off the new data frame, generate heat map
# Assuming you have a data frame `differences_df` with columns  'Position', 'Reference', and 'Variant'

# Count the occurrences of each variant at each position
variant_counts <- table(differences_df$Position, differences_df$Variant)

#rows = genomes, columns = positions, value = position new
#variationSites_df = data-frame
#id = position
#all names of genomes = df, and values of each site of variation for each positon
df <- melt(variationSites_df,id = 'Position')
#refernecevalues for sites of variation only
# %>% = dplyer operator
referencemap = df %>% filter(variable=="reference_pt101")
colnames(referencemap) = c("Position","refname","refvalue")
unique(df$Position)

#dplyr is using df as x
#by = shared variable
completemap = df %>% left_join(referencemap, by = "Position")

#mutate() <-- use this to tell it to make it variant if the variable value = ref value, and notVariant if not
# need to pipe to give it the dataframe. left joined one with the references and the genomes = completemap
#variant_determinator = new data frame with the genome and ref info, and where or not variation at that site
variant_determinator <- completemap %>% mutate(variant = if_else(value==refvalue, "notVariant", "variant" ))

#variant = name of variable
#heatmap_binary =ggplot(variant_determinator, aes(x = factor(Position), y = variable, fill = variant)) +geom_tile()
 
p <- Treeplot+geom_tippoint(mapping=aes(color=patient), size=4,show.legend=T)
p + new_scale_fill() +geom_fruit(data=df, geom=geom_tile, mapping=aes(y= variable, x= factor(Position), fill=variant_determinator),axis.params=list(axis="x",
               title = "Amino Acid Position",
               text.angle = -45,
               text.size = 2,
               line.size = 0,
               vjust = 0), 
             color = "grey50", offset = 0.25,size = 0.02) + scale_fill_manual(values=c("white","black","white","black","white","black","white","black","white","black","white","black","white","black","white","black","white"))

