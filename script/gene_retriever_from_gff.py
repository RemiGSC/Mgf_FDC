# -*- coding: utf-8 -*-
"""
Created on Mon Jan  2 16:42:54 2023

@author: remi.gschwind
"""

### Retrieving information in the gff file ###
##FROM PROKKA##
gff_directory="C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/output/prokka_inserts/inserts.gff"
gff_list = []
with open(gff_directory , 'r') as f :
    for line in f :
        if "CDS" in line :
            ech = line.strip().split('\t')[0]
            start = line.strip().split('\t')[3]
            stop = line.strip().split('\t')[4]
            strand = line.strip().split('\t')[6]
            annotation = line.strip().split("product=")[1].strip().split("\"")[0].replace(' ', '_')
            gff_list.append(ech + ';' + start + ';' + stop + ';' + strand + ';' + annotation)


### Retrieving the sequence of the genes in a fasta file ###
fasta_in = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/data/mgf_inserts_FDCr.fasta"
fasta_out = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/data/prokka_mgf_genes_FDCr.fasta"
fasta_write = []
from Bio import SeqIO

for inserts in SeqIO.parse(fasta_in, 'fasta') :
    #id comparison
    for element in gff_list :
        ech = element.strip().split(";")[0]
        start = element.strip().split(";")[1]
        stop = element.strip().split(";")[2]
        strand = element.strip().split(";")[3]
        annotation = element.strip().split(";")[4]
        if ech == inserts.id :
            if strand == "+" :
                fasta_write.append(">" + ech + "_" + annotation + "\n" + inserts.seq[int(start)-1:int(stop)])
            else :
                fasta_write.append(">" + ech + "_" + annotation + "\n" + inserts.seq[int(start)-1:int(stop)].reverse_complement())
        
### Writing the genes in a new fasta file ###
with open(fasta_out, 'w') as f :
    for entries in fasta_write :    
        f.write(str(entries) + '\n')


##FROM BAKTA##
# output from bakta was manually modified to include samples names.
gff_directory="C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/output/bakta_inserts/mgf_inserts_FDCr.fasta.gff3"
gff_list = []
with open(gff_directory , 'r') as f :
    for line in f :
        if "CDS" in line :
            ech = line.strip().split('\t')[0]
            start = line.strip().split('\t')[3]
            stop = line.strip().split('\t')[4]
            strand = line.strip().split('\t')[6]
            annotation = line.strip().split("product=")[1].strip().split("\"")[0].replace(' ', '_')
            gff_list.append(ech + ';' + start + ';' + stop + ';' + strand + ';' + annotation)


### Retrieving the sequence of the genes in a fasta file ###
fasta_in = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/data/mgf_inserts_FDCr.fasta"
fasta_out = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/data/bakta_mgf_genes_FDCr.fasta"
fasta_write = []
from Bio import SeqIO

for inserts in SeqIO.parse(fasta_in, 'fasta') :
    #id comparison
    for element in gff_list :
        ech = element.strip().split(";")[0]
        start = element.strip().split(";")[1]
        stop = element.strip().split(";")[2]
        strand = element.strip().split(";")[3]
        annotation = element.strip().split(";")[4]
        print(ech , inserts.id)
        if ech == inserts.id :
            if strand == "+" :
                fasta_write.append(">" + ech + "_" + annotation + "\n" + inserts.seq[int(start)-1:int(stop)])
            else :
                fasta_write.append(">" + ech + "_" + annotation + "\n" + inserts.seq[int(start)-1:int(stop)].reverse_complement())
        
### Writing the genes in a new fasta file ###
with open(fasta_out, 'w') as f :
    for entries in fasta_write :    
        f.write(str(entries) + '\n')   

### translating into protein and write in a new fasta file
protein_out = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/Mgf_FDC/data/mgf_protein_FDCr.fasta"
protein_write = []        
for genes in SeqIO.parse(fasta_out, "fasta") :
    protein_write.append(">" + genes.id + "\n" + genes.seq.translate())
    
with open(protein_out, 'w') as f :
    for entries in protein_write :
        f.write(str(entries) + '\n')

    
