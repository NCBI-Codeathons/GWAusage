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
* [WorkFlow](https://github.com/NCBI-Codeathons/ID-GWAS.git#workFlow)
* [Pipeline](https://github.com/NCBI-Codeathons/ID-GWAS.git#quickstart)
* [Help](https://github.com/NCBI-Codeathons/ID-GWAS.git#help)
* [Inputs](https://github.com/NCBI-Codeathons/ID-GWAS.git#inputs)
* [Outputs](https://github.com/NCBI-Codeathons/ID-GWAS.git#outputs)


## Introduction

The genome-wide association study (GWAS) has become a staple of geneticists worldwide. While GWASs are commonly conducted, the process is often cumbersome, involving multiple programs for data formatting, quality control, and analysis, and often these programs are initialized one at a time by the researcher conducting the analysis. This leads to time lost to processes that can be automated. Here, we introduce GWAusage, an analysis tool designed to automate and streamline the GWAS. With GWAusage, a researcher need only provide genotype or sequencing files, in variant call format (vcf) or Plink format, and formatted phenotype and covariate files in order to conduct a GWAS, generate plots, and querying databases for additional information on single nucleotide polymorphisms (SNPs) of interest. GWAusage automates data formatting, step-wise regression analysis, and generating a genetic relatedness matrix. Using this analysis tool, researchers can easily conduct GWASs and gain valuable time to dedicate to other areas of research.

## Goals
1. Retreive and visualize SNPs associated to phenotype of interest.
2. Mine Databases to identify additional pre-estblished SNP-phenotype associations.

A genome-wide association study (GWAS) is an approach used in genetics research to associate specific genetic variations with particular diseases. The method involves scanning the genomes from many different people and looking for genetic markers that can be used to predict disease suceptibility.

The first goal is to generate an automated pipline using tabular vcf and/or bam files as well as covariate table files to determine the most significant phenotype-associated SNPs.

The second goal is to interogate public databases to determine if newly identified SNPs have also been associated to other clinical conditions.

## Workflow
![My image](https://github.com/NCBI-Codeathons/ID-GWAS/blob/master/Workflow_visualization.png)

## Instructions for Use
### Installation
### User provided inputs
GWAusage requires a genotyping data file and a phenotype file. Covariates must be separated into a file of discrete covariates and a file of continuous covariates. See [Inputs](https://github.com/NCBI-Codeathons/ID-GWAS.git#inputs) for additional information on the format of these files.
### Running GWAusage

## Methods

GWAusage accepts inputs to the pipeline of genotype data in variant call format (VCF) or Plink format (BED, BIM, and FAM), as well as phenotype data and covariate data.  Minimum allele frequency is set by the user or a default of 1% (0.01).  The genotype data is filtered through Plink (ver. 1.9) with the allelic frequency applied.  The phenotype and covariate data are then merged in R (ver. 3.5).  Stepwise regression is performed with the MASS R package (ver 7.3) in forwards and backwards directionality.  Significant covariates are preserved and exported. A genetic relatedness matrix is calculated on the genotyping data via GCTA (ver 1.93).  The matrix is then filtered to find individuals in the population above the cutoff (0.05 default).


Using the qqman R package (ver 0.1.4), manhattan plots are created to visualize SNPs of interest along the genome. A suggestive line (-log10(1e-5)) and genome-wide significance line (-log10(5e-8)) are displated on the graph. P values from each SNP from smallest to larges are plotted on a QQ plot to visualize the deviation of values that are expected under the null hypothesis.

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
-  Phenotype file - Containing three columns: FID, IID, and phenotype. One subject per row. No header.

-  Continuous covariate file - Contains at least three columns: FID, IID, then an additional column for each continuous covariate. One subject per row. No header.

-  Discrete covariates - Contains at least three columns: FID, IID, then an additional column for each discrete covariate. One subject per row. No header.

-  VCF or Plink format (bim, bed, and fam or map and ped) genotyping files.

## Dependencies
1. plink v1.9 (https://www.cog-genomics.org/plink/1.9/)
2. gtca v1.93.0 (https://cnsgenomics.com/software/gcta/#Download)
3. R v3.5 
### R packages
  * shinydashboard
  * shiny
  * dplyr
  * leaflet
  * dashboardthemes
  * data.table 
  * RColorBrewer
  * ggplot2
  * plotly
  * shinyWidgets
  * shinycssloaders
  * MASS
  * qqman
  * haploR


