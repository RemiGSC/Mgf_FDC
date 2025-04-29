#!/bin/bash

K12="/mnt/c/Users/remi.gschwind/Desktop/K12.fasta"
GER1="/mnt/c/Users/remi.gschwind/Desktop/GER1.fasta"
GER3="/mnt/c/Users/remi.gschwind/Desktop/GER3.fasta"
GER5="/mnt/c/Users/remi.gschwind/Desktop/GER5.fasta"
SWE1="/mnt/c/Users/remi.gschwind/Desktop/SWE1.fasta"
PGN="/mnt/c/Users/remi.gschwind/Desktop/PGN.fasta"

parsnp -r "$K12" -d "$PGN" "$GER1" "$GER3" "$GER5" "$SWE1" -o "/root/parsnp/output" --force --vcf