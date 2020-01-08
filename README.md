# GWAusage
## Comprehensive Shiny App for complex trait GWAS implementing data mining

![My image](https://github.com/NCBI-Codeathons/ID-GWAS/blob/master/GWAusageLogo.png)



**Contributors**

 * Sheng Zhang - Developer
 * Owen Baker - Developer
 * William Schwarzmann - Developer
 * Richard Copin - Writer
 * Brandon Blobner - Lead

## Table of Contents
* [Intro](https://github.com/NCBI-Hackathons/ID-GWAS.git#intro)
* [Quickstart](https://github.com/NCBI-Hackathons/ID-GWAS.git#quickstart)
* [Help](https://github.com/NCBI-Hackathons/ID-GWAS.git#help)
* [Inputs](https://github.com/NCBI-Hackathons/ID-GWAS.git#inputs)
* [Outputs](https://github.com/NCBI-Hackathons/ID-GWAS.git#outputs)
* [WorkFlow](https://github.com/NCBI-Hackathons/ID-GWAS.git#workFlow)

## Intro
### Goal
1. Retreive and visualize SNPs associated to phenotype of interest.
2. Mine Databases to identify additional pre-estblished association for each SNPs

A genome-wide association study (GWAS) is an approach used in genetics research to associate specific genetic variations with particular diseases. The method involves scanning the genomes from many different people and looking for genetic markers that can be used to predict disease suceptibility.

The first goal is to generate an automated pipline using tabular vcf and/or bam files as well as covariate table files to determine the most significant phenotype-associated SNPs.

The second goal is to interogate public databases to determine if newly identified SNPs have also been associated to other clinical conditions.

### Pipeline
# Module 1: Input / Filtering using Plink
* Formatting the genotyping data (from vcf to plink format)
* Filtering SNPs and individuals

# Module 2: 
* Generate the full model from a phenotype and covariant file
* Stepwise regression to determine the contributing covariates 
* GCTA generate a genetic relatedness metrics
* Conduct GWAS

# Module 3:
* Visual representation
* Filter the significant loci (determine thresholds)
* locusZoom

# Module 4: 
* Interrogate public databases to determine the significance of each SNPs in different conditions
