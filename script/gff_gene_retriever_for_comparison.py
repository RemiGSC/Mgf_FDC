# -*- coding: utf-8 -*-
"""
Created on Tue Jan  7 10:16:11 2025

@author: remi.gschwind
"""

dir_path = "//catibiomed.bichat.inserm.fr/IAME/metagenomique_fonctionelle/output/"
output_gene_path = "//catibiomed.bichat.inserm.fr/IAME/metagenomique_fonctionelle/output/gene_comparison/"


list_gene = ["mrcB", "fiu", "fepA", "fepB", "fecA", "fhuA", "tonB", "pcnB", "exbB", "exbD", "baeS" , "baeR", "ompR" , "ompK", "envZ" , "ftsI"]
with open("//catibiomed.bichat.inserm.fr/IAME/metagenomique_fonctionelle/output/list_gene.txt" , 'r') as f :
    for line in f :
        list_gene.append(str(line.strip().split()[0]))
for gene in list_gene :
    import os 
    search_list = []
    gene_to_check = gene
    for file in os.listdir(dir_path) :
        if "prokka_spades" in file :
            for file_bis in os.listdir(dir_path + file + '/'):
                if ".gff" in file_bis :
                    with open(dir_path + file + '/' + file_bis) as f :
                        for line in f : 
                            if gene_to_check in line : 
                                contig = line.strip().split("\t")[0]
                                start = int(line.strip().split("\t")[3])-1
                                stop = int(line.strip().split("\t")[4])
                                search_list.append(str(contig) + '\t' + str(start) + '\t' + str(stop))
    list_fasta = []
    from Bio import SeqIO 
    from Bio.Seq import Seq   
    for file in os.listdir(dir_path) :
        if "_25" not in file and "prokka" not in file :
            if "_spades" in file :
                for file_bis in os.listdir(dir_path + file + '/') :
                    if "contigs.fasta" in file_bis or "crop.fasta" in file_bis :
                        for contigs in SeqIO.parse(dir_path + file + '/' + file_bis , 'fasta') :
                            for element in search_list :
                                if contigs.id == element.strip().split('\t')[0] :
                                    if (contigs.seq[int(element.strip().split('\t')[1]):int(element.strip().split('\t')[2])][0:3] == "ATG" 
                                        or contigs.seq[int(element.strip().split('\t')[1]):int(element.strip().split('\t')[2])][0:3] == "GTG") :
                                        sequence = contigs.seq[int(element.strip().split('\t')[1]):int(element.strip().split('\t')[2])]
                                        print('>' + gene_to_check + '_' + file + '\n' + 
                                              sequence)
                                        list_fasta.append('>' + gene_to_check + '_' + file + '\n' + 
                                              sequence)
                                    else :
                                        sequence = Seq(contigs.seq[int(element.strip().split('\t')[1]):int(element.strip().split('\t')[2])]).reverse_complement()
                                        print('>' + gene_to_check + '_' + file + '\n' + 
                                              sequence)
                                        list_fasta.append('>' + gene_to_check + '_' + file + '\n' + 
                                              sequence)
    with open(output_gene_path + gene + ".fasta" , 'w') as f :
        for entries in list_fasta : 
            f.write(str(entries) + '\n')

### ALIGNEMENT USING MAFFT ON WSL ###
# #!/bin/bash

# fasta_dir="/mnt/c/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/gene_comparison" # Absolute WSL path

# for fasta_file in "$fasta_dir"/*.{fasta,fa}; do
#   if [[ -f "$fasta_file" ]]; then
#     filename=$(basename "$fasta_file")
#     filename="${filename%.*}"
#     output_file="$fasta_dir/${filename}_aligned.clustal"
#     mafft --auto --clustalout "$fasta_file" > "$output_file" 2> error.log # Error redirection
#     echo "Aligned $fasta_file to $output_file"
#   fi
# done

# echo "Finished aligning all FASTA files."
# ls -l "$fasta_dir" # List files for verification
            
### RAMENER LES ALIGNEMENTS AU BON ENDROIT ###      
import os
dir_alignment = "//catibiomed.bichat.inserm.fr/IAME/metagenomique_fonctionelle/output/gene_comparison/"
for file in os.listdir(dir_alignment) :
    x = 0
    if "clustal" in file :
        with open(dir_alignment + file, 'r') as f:
            for line in f:
                x += 1
                # Correct implementation using modulo
                if x % 7 == 2:  # Check if x has a remainder of 2 when divided by 7
                    if " " in (line[16:]) or "." in (line[16:]) :
                        print(file.strip().split('_')[0])# , '\n' , line[16:])
                        break

            
