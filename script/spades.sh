#!/bin/bash

###### ASSEMBLAGE DES READS POST QUALITY ######

#### K12 ####

mkdir /home/remi.gschwind/metagenomique_fonctionelle/output/K12/K12_spades
dir_output="/home/remi.gschwind/metagenomique_fonctionelle/output/K12/K12_spades/post_quality"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/K12/quality/K12_pHSG_R1_val_1.fq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/K12/quality/K12_pHSG_R2_val_2.fq.gz"
mkdir "$dir_output"

spades -t 20 --careful -o "$dir_output" -1 "$R1" -2 "$R2"

#### GER1 ####

mkdir /home/remi.gschwind/metagenomique_fonctionelle/output/GER1/GER1_spades 
dir_output="/home/remi.gschwind/metagenomique_fonctionelle/output/GER1/GER1_spades/post_quality"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER1/quality/GER1_R1_val_1.fq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER1/quality/GER1_R2_val_2.fq.gz"
mkdir "$dir_output"

spades -t 20 --careful -o "$dir_output" -1 "$R1" -2 "$R2"

#### GER3 ####

mkdir /home/remi.gschwind/metagenomique_fonctionelle/output/GER3/GER3_spades
dir_output="/home/remi.gschwind/metagenomique_fonctionelle/output/GER3/GER3_spades/post_quality"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER3/quality/GER3_R1_val_1.fq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER3/quality/GER3_R2_val_2.fq.gz"
mkdir "$dir_output"

spades -t 20 --careful -o "$dir_output" -1 "$R1" -2 "$R2"

#### GER5 ####

mkdir /home/remi.gschwind/metagenomique_fonctionelle/output/GER5/GER5_spades
dir_output="/home/remi.gschwind/metagenomique_fonctionelle/output/GER5/GER5_spades/post_quality"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/GER5/quality/GER5_R1_val_1.fq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/GER5/quality/GER5_R2_val_2.fq.gz"
mkdir "$dir_output"

spades -t 20 --careful -o "$dir_output" -1 "$R1" -2 "$R2"

#### SWE1 ####

mkdir /home/remi.gschwind/metagenomique_fonctionelle/output/SWE1/SWE1_spades
dir_output="/home/remi.gschwind/metagenomique_fonctionelle/output/SWE1/SWE1_spades/post_quality"
R1="/home/remi.gschwind/metagenomique_fonctionelle/data/SWE1/quality/SWE1_R1_val_1.fq.gz"
R2="/home/remi.gschwind/metagenomique_fonctionelle/data/SWE1/quality/SWE1_R2_val_2.fq.gz"
mkdir "$dir_output"

spades -t 20 --careful -o "$dir_output" -1 "$R1" -2 "$R2"
