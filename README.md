## Mgf_FDC ##
Data and scripts associated with the work: "Identification of cefiderocol resistance genes in the environment using functional metagenomics"


- Inserts sequences were retrieved after colony PCR and Sanger sequencing of the inserted region in the expression plasmid pHSG299.

- Inserts sequences were subjected to annotation by BAKTA and PROKKA.
	- For PROKKA annotation, the following script was used : script/prokka_inserts.sh (PROKKA v1.14).
	- For BAKTA annotation, the webserver was used (https://doi.org/10.1093/nar/gkaf335).
	- Output files are found in output/bakta_inserts/ and in output/prokka_inserts/

- Output gff files from PROKKA and BAKTA were used to retrieve gene sequences. 
	- The following script was used : script/gene_retriever_from_gff.py. 
	- It retrieve information from the gff files and use it to retrieve only gene sequences from the inserts.
	- Output fasta files can be found in data/

- Genes fasta file were used as input on the ResFinderFG (v2.0) and ResFinder (v4.7.2) webservers (Genes retrieved using BAKTA and PROKKA output were identical so the analysis was run using only data/prokka_mgf_genesFDCr.fasta). 
	- Standard parameters were used for both: Selected %ID threshold:  98 % ; Selected minimum length:  60 %
	- ResFinder analysis output: output/ARG_inserts/ResFinder_results_tab.txt
	- ResFinderFG analysis output: output/ARG_inserts/ResFinderFG_results_tab.txt

- Genes fasta file was translated to proteins fasta file.
	- input file: /data/bakta_mgf_genes_FDCr.fasta
	- output file: /data/mgf_protein_FDCr.fasta
	- Output file was used for blastp analysis with the nr database. 
		- nr database version.
			Title:All non-redundant GenBank CDS translations+PDB+SwissProt+PIR+PRF excluding environmental samples from WGS projects
			Molecule Type:Protein
			Update date:2025/04/28
			Number of sequences:910289766
		- results of this analysis are found in ARG_protein_blastp/ folder. 

- Inserts taxonomy was analyzed using BLASTN online and the Core nucleotide database (core_nt)
	- db version : 
		Title:Core nucleotide BLAST database
		Description:The core nucleotide BLAST database consists of GenBank+EMBL+DDBJ+PDB+RefSeq sequences, but excludes EST, STS, GSS, WGS, TSA, patent sequences as well as phase 0, 1, and 2 HTGS sequences and most eukaryotic chromosome sequences. 
		The database is non-redundant. Identical sequences have been merged into one entry, while preserving the accession, GI, title and taxonomy information for each entry.
		Molecule Type:mixed DNA
		Update date:2025/04/28
		Number of sequences:114586527
	- output text files are found in output/inserts_blastn_taxo/

- Metagenomic analysis of the microbial diversity of each sample.
	- Input file is: data/Metagenomic_seq_motusv3.0.tsv
	- Bray Curtis disimilarity analysis was run and pcoa was made using the R script: script/script_pcoa.txt
	- Figure was then modified on Inkscape to include legends of functional metagenomic analysis.
	
- Abundance analysis of ARGs identified using functional metagenomics in metagenomic sequencing of each sample. 
	- Input file is: data/relativeab_ARGs_metagenomic_seq.csv
	- Barplot were realised using the following script:  script/script_barplot/
	- Maps were obtained using the following script: script/script_map.txt
	- Figure was then arranged using inkscape

- Analysis of GER-5-KREISCHAOUT genes (short and extended version) alignement with targets of cefiderocol.
	- Protein file /data/mgf_protein_FDCr.fasta was used on AlphaFold 3 webserver for protein folding predictions.
		- Resulting .cif files are found in output/alphafold/
	- Each protein was aligned to every other protein using Pymol (v3.1.4) with the command: super p1, p2.
	- Heatmap of the result matrix was done using the script: script/script_heatmap.txt
	- Figure was done using Inkscape.

- Analysis of mutations in K12 expressing FDC ARGs
	- K12 containing recombining pHSG299 plasmids were sequenced using Illumina.
	- fastqc was used to analyze reads quality and trim-galore was used for quality trimming. 
		- The script used can be found here: script/quality.sh
	- Read assembly was made using SPADES (v3.15.4) with the Following script: script/spades.sh
	- Each assembly was annotated using PROKKA. 
	- Gene names involved in cefiderocol resistance was found from literature. They are described in data/list_genes_FDCassociated.txt 
		- Each genes was searched in PROKKA (v1.14) gff files and sequences were retrieved. 
		- Each sequence of genes in clone containing FDC ARGs was compared to the same gene in the K12 containing an empty expression vector. 
		- This was done with the script: script/gff_gene_retriever_for_comparison.py
		- Results are found in the folder output/gene_comparison/
	- Additionnally, a PARSNP (Parsnp v2.1.3) analysis was done using the script script/parsnp.sh
		- Resulting output table is found in output/

- Metagenomic reads were used for contig assembly using ngless .
	- ngless contigs can be found in output/ngless_contigs/
	- ARGs identified using functional metagenomics were then used to be mapped on contigs. 
		- Results can be found in: output/Blastn_Contigs/ 
		- It has to be noted that no results were retrieved for sample GER-3-ELBE WATER.


- GMGC distribution
	- Each protein encoded by FDC ARGs identified using functional metagenomics was analyzed on GMGC webserver (https://gmgc.embl.de/index.cgi). 
	- Results can be found in output/GMGC/
	- Only GER-1-KREISCHAIN protein displayed satisfactory homology.
		- To analyze the distribution of the homolog in the GMGC catalaog, a grep command was made on the metadata.
			- xzgrep "GMGC10.001_990_215.UNKNOWN" GMGC10.sample-abundance.tsv.xz > result_grep_GER-1-KREISCHAIN_homolog.txt
			- Results are found here: output/GMGC/result_grep_GER-1-KREISCHAIN_homolog.txt
		- To match the habitat, matching_habitat_gmgc.py was used.
			- Results are found here: output/GMGC/result_grep_GER-1-KREISCHAIN_homolog_habitat.txt
	

- Enterobase distribution
	- Enterobase analysis was done using blastn in the Following script: script/enterobase_analysis.sh
	- Each blast results output was concatenated and can be found in the file: output/enterobase/enterobase_blastn_ARGs.txt
		- Only results with %id>95% were considered.
	- Metadata of each hit was retrieved using the Following script: script/enterobase_metadata.sh
		- Results can be found here: output/enterobase/metadata_enterobase_results.txt
	

	
	





	
	

