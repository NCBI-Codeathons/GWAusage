# GWAusage
## Comprehensive Shiny App for complex trait GWAS implementing data mining.

![My image](https://github.com/NCBI-Codeathons/ID-GWAS/blob/master/GWAusageLogo.png)



## Contributors

 * Sheng Zhang - Developer
 * Owen Baker - Developer
 * William Schwarzmann - Developer
 * Richard Copin - Developer/Writer
 * Brandon Blobner - Developer/Lead

## Table of Contents
* [Goals](https://github.com/NCBI-Codeathons/ID-GWAS.git#intro)
* [Pipeline](https://github.com/NCBI-Codeathons/ID-GWAS.git#quickstart)
* [Help](https://github.com/NCBI-Codeathons/ID-GWAS.git#help)
* [Inputs](https://github.com/NCBI-Codeathons/ID-GWAS.git#inputs)
* [Outputs](https://github.com/NCBI-Codeathons/ID-GWAS.git#outputs)
* [WorkFlow](https://github.com/NCBI-Codeathons/ID-GWAS.git#workFlow)

## Goals
1. Retreive and visualize SNPs associated to phenotype of interest.
2. Mine Databases to identify additional pre-estblished SNP-phenotype associations.

A genome-wide association study (GWAS) is an approach used in genetics research to associate specific genetic variations with particular diseases. The method involves scanning the genomes from many different people and looking for genetic markers that can be used to predict disease suceptibility.

The first goal is to generate an automated pipline using tabular vcf and/or bam files as well as covariate table files to determine the most significant phenotype-associated SNPs.

The second goal is to interogate public databases to determine if newly identified SNPs have also been associated to other clinical conditions.

## Introduction

The genome-wide association study (GWAS) has become a staple of geneticists worldwide. While GWASs are commonly conducted, the process is often cumbersome, involving multiple programs for data formatting, quality control, and analysis, and often these programs are initialized one at a time by the researcher conducting the analysis. This leads to time lost to processes that can be automated. Here, we introduce GWAusage, an analysis tool designed to automate and streamline the GWAS. With GWAusage, a researcher need only provide genotype or sequencing files, in variant call format (vcf) or Plink format, and formatted phenotype and covariate files in order to conduct a GWAS, generate plots, and querying databases for additional information on single nucleotide polymorphisms (SNPs) of interest. GWAusage automates data formatting, step-wise regression analysis, and generating a genetic relatedness matrix. Using this analysis tool, researchers can easily conduct GWASs and gain valuable time to dedicate to other areas of research.

## Pipeline
### Module 1: Input / Filtering using Plink
* Formatting the genotyping data (from vcf to plink format)
* Filtering SNPs and individuals

### Module 2: 
* Generate the full model from a phenotype and covariant file
* Stepwise regression to determine the contributing covariates 
* GCTA generate a genetic relatedness metrics
* Conduct GWAS

### Module 3:
* Visual representation
* Filter the significant loci (determine thresholds)
* locusZoom

### Module 4: 
* Interrogate public databases to determine the significance of each SNPs in different conditions

## Input Files
-  Phenotype

-  continuous covariates

-  discrete covariates

-  VCF or BAM


