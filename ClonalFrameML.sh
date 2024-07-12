#using the ClonalFrameMLEnv

#Goal: go into the best tree created with RAxML to do a recombination analysis to find M. Avium regions that are hotspots for recombination and create a masked alignment (an alignment with the hotspot regions masked)

mkdir -p /Users/charanjeetdhillon/Documents/MAvium/ClonalFrameMLFiles/

newick_file=/Users/charanjeetdhillon/Documents/MAvium/Tree/RAxML_bestTree.MAviumPhylogeneticTree
output_prefix=/Users/charanjeetdhillon/Documents/MAvium/ClonalFrameMLFiles/MaskedAlignment
seq_file=/Users/charanjeetdhillon/Documents/MAvium/SnippyFiles/clean.full.aln

#-output_filtered = puts out masked alignmentment. -emsim = how many simulations you want to do. Accessing #confidence in model
ClonalFrameML $newick_file $seq_file $output_prefix -output_filtered true -emsim 100






