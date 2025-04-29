# -*- coding: utf-8 -*-
"""
Created on Wed Oct 11 16:58:29 2023

@author: remi.gschwind
"""

import requests

grep_results = "D:/GMGC/result_grep_ger1bis.txt"
habitat_output = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/result_grep_habitat.txt"
grep = []
with open(grep_results , 'r') as f :
    for line in f :
        grep.append(line.strip())
out = []
for element in grep :
    sample = element.strip().split('\t')[1]
    r_sample = requests.get(f"https://gmgc.embl.de/api/v1.0/sample/{sample}")
    habitat = str(r_sample.content).strip().split(',')[2].strip().split('\"')[3]
    out.append(element + '\t' + habitat)

with open(habitat_output , 'w') as f :
    for element in out :
        f.write(element + '\n')