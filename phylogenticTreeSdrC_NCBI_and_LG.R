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

mAviumPatientTree <- ape::read.tree(file="/Users/charanjeetdhillon/Documents/MAvium/RAxML_sdrCPhylogeneticTree/RAxML_bestTree.sdrCPhylogeneticTree")
mAviumPatientTree
rootedMAviumPatientTree <- phytools::midpoint.root(mAviumPatientTree)
rootedMAviumPatientTree
#ggtree(rootedMAviumPatientTree,layout="rectangular")
#ggtree(mAviumPatientTree)

Treeplot <- ggtree(rootedMAviumPatientTree,layout="rectangular")

Treeplot$data

Treeplot$data = Treeplot$data %>% left_join(MyDataFrame,by="label")

allsdrCLongitudinalStudyGenomesMultiFasta <- "/Users/charanjeetdhillon/Documents/MAvium/clustalW_sdrCMultiFastaNCBIandLGGenomes7.1.fasta"
alignedSeqs <- seqinr::read.fasta(file = allsdrCLongitudinalStudyGenomesMultiFasta)
reference <- alignedSeqs$Reference
variationSites <- list()
Position <- c()

for (i in 1:length(alignedSeqs[[1]])) {
column <- lapply(alignedSeqs, function(x) x[i])
if (length(unique(column)) > 1 && i<=333) {
  variationSites[[i]] <- column
  Position <- append(Position, i)
  }
}
variationSites_df <- do.call(rbind.data.frame, variationSites)
variationSites_df$Position = Position

reference <- alignedSeqs$Reference

df <- melt(variationSites_df,id = 'Position')
referencemap = df %>% filter(variable=="Reference")
colnames(referencemap) = c("Position","refname","refvalue")
unique(df$Position)
completemap = df %>% left_join(referencemap, by = "Position")
variant_determinator <- completemap %>% mutate(variant = if_else(value==refvalue, "notVariant", "variant" ))



e <- ggplot(df, aes(x = factor(Position), y = variable, fill = value)) +
  geom_tile() + ggtitle("Variation in Mycobacterium Avium sdrC") +
  scale_x_discrete()
f <- e + theme(axis.text=element_text(size=2)) + theme(axis.title=element_text(size=10))+ theme(legend.title=element_text(size=10))+ theme(legend.text=element_text(size=10)) + theme(legend.title = element_text(size=10)) + theme(plot.title=element_text(size=10))
g <- f + theme(legend.key.size=unit(.1,'cm')) + scale_fill_manual(values=c("#ffff00","lightsalmon","#6c5b7b", "#2d5a4b", "#d17397", "#aa4a01", "red", "blue", "purple","green","#99ccff","darkolivegreen","chocolate1","deeppink3","darkred"," bisque" ))
g 
ggsave(g, file="TileMapsdrCAll.pdf", width=10, height=5)
heatmap_binary=ggplot(variant_determinator, aes(x = factor(Position), y = variable, fill = variant)) +
  geom_tile()
p <- Treeplot + geom_tiplab(aes(x=branch), size=.5, color="brown", vjust=-0.3) + theme(aspect.ratio = .05) + theme(plot.margin = unit(c(14,8,14,8), "mm")) + 
  geom_treescale(0.001)
p

