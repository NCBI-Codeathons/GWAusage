# GWAusage


![My image](https://github.com/NCBI-Codeathons/ID-GWAS/blob/master/logo.png)

Comprehensive package for complex trait GWAS implementing data mining

**Contributors**

 * Sheng Zhang - Developer
 * Owen Baker - Developer
 * William Schwarzmann - Developer
 * Richard Copin - Writer
 * Brandon Blobner - Lead


### Pipeline
Module 1: Input / Filtering using Plink
* Formatting the genotyping data (from vcf to plink format)
* Filtering SNPs and individuals
Module 2: 
* Generate the full model from a phenotype and covariant file
* Stepwise regression to determine the contributing covariates 
* GCTA generate a genetic relatedness metrics
* Conduct GWAS
Module 3:
* Visual representation
* Filter the significant loci (determine thresholds)
* locusZoom
Module 4: 
* Interrogate public databases to determine the significance of each SNPs in different conditions
