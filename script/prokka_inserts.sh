#!/bin/bash

prokka --cpus 6 --locustag prokka --gcode 11 --outdir ../output/prokka_inserts --prefix inserts ../data/mgf_inserts_FDCr.fasta --force