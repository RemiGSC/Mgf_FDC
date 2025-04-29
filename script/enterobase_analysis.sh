#!/bin/bash

dir_ecoli="/home/Enterobase/E.coli/"
fasta_genes="/home/remi.gschwind/metagenomique_fonctionelle/data/FDC_genes.fasta"
output_dir="/home/remi.gschwind/metagenomique_fonctionelle/output/enterobase/E.coli/"

mkdir -p "$output_dir"

for element in "$dir_ecoli"*; do
    filename=$(basename "$element")
    output_subdir="$output_dir/$filename"
    output_file="$output_subdir/$filename.blastn"

    # Check if the output file already exists
    if [[ -f "$output_file" ]]; then
        echo "Output file '$output_file' already exists. Skipping."
        continue  # Go to the next file in the loop
    fi

    mkdir -p "$output_subdir"

    blastn -query "$fasta_genes" -task blastn -out "$output_file" -subject "$element" -qcov_hsp_perc 10 -outfmt "6 qseqid sseqid pident qlen slen qcovhsp length mismatch gapopen qstart qend sstart send evalue bitscore"

    if [[ $? -ne 0 ]]; then
        echo "ERROR: blastn failed for $element. Check the log file."
        # Optionally exit:
        # exit 1
    fi

done

echo "Blast analysis complete."