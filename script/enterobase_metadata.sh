#!/bin/bash

samples=("ESC_RA9125AA_AS" "ESC_VA2039AA_AS" "ESC_LA1083AA_AS" "ESC_IA6016AA_AS" "ESC_IA4025AA_AS" "ESC_NA7870AA_AS" "ESC_IA4024AA_AS" "ESC_IA4897AA_AS" "ESC_KA9999AA_AS")  # Array definition using parentheses

metadata_file="/home/Enterobase/Metadata/typing_coli.txt"

for ech in "${samples[@]}"; do  # Correct way to iterate over an array
  grep "$ech" "$metadata_file"
done