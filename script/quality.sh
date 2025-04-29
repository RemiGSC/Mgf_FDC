#!/bin/bash

#### K12 pHSG ####

dir_data="/home/remi.gschwind/metagenomique_fonctionelle/data/K12"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/K12/K12_pHSG_R1.fastq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/K12/K12_pHSG_R2.fastq.gz"

mkdir "$dir_data/quality"

fastqc -o "$dir_data/quality/" "$R1"
fastqc -o "$dir_data/quality/" "$R2"

trim_galore --quality 30 --length 50 --output_dir "$dir_data/quality/" --paired "$R1" "$R2"

#### GER1 ####

dir_data="/home/remi.gschwind/metagenomique_fonctionelle/data/GER1"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER1/GER1_R1.fastq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER1/GER1_R2.fastq.gz"

mkdir "$dir_data/quality"

fastqc -o "$dir_data/quality/" "$R1"
fastqc -o "$dir_data/quality/" "$R2"

trim_galore --quality 30 --length 50 --output_dir "$dir_data/quality/" --paired "$R1" "$R2"

#### GER3 ####

dir_data="/home/remi.gschwind/metagenomique_fonctionelle/data/GER3"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER3/GER3_R1.fastq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER3/GER3_R2.fastq.gz"

mkdir "$dir_data/quality"

fastqc -o "$dir_data/quality/" "$R1"
fastqc -o "$dir_data/quality/" "$R2"

trim_galore --quality 30 --length 50 --output_dir "$dir_data/quality/" --paired "$R1" "$R2"

#### GER5 ####

dir_data="/home/remi.gschwind/metagenomique_fonctionelle/data/GER5"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER5/GER5_R1.fastq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER5/GER5_R2.fastq.gz"

mkdir "$dir_data/quality"

fastqc -o "$dir_data/quality/" "$R1"
fastqc -o "$dir_data/quality/" "$R2"

trim_galore --quality 30 --length 50 --output_dir "$dir_data/quality/" --paired "$R1" "$R2"

#### SWE1 ####

dir_data="/home/remi.gschwind/metagenomique_fonctionelle/data/SWE1"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/SWE1/SWE1_R1.fastq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/SWE1/SWE1_R2.fastq.gz"

mkdir "$dir_data/quality"

fastqc -o "$dir_data/quality/" "$R1"
fastqc -o "$dir_data/quality/" "$R2"

trim_galore --quality 30 --length 50 --output_dir "$dir_data/quality/" --paired "$R1" "$R2"
