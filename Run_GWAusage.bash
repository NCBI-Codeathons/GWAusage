#!/bin/bash

module load R/3.6.0-mkl
PATH=/pylon5/brz3a1p/wis29/gcta_1.93.0beta/:$PATH

#Format genotyping with Plink goes here


#Perform stepwise regression
Rscript regression.R

#Rename files
rm discrete_covariates.txt
mv disc_cov.txt discrete_covariates.txt
rm continuous_covariates.txt
mv cont_cov.txt continuous_covariates.txt

#gcta64 --make-grm mydata

#Perform GWAS
gcta64 --mlma --bfile mydata --grm mydata \
       --pheno phenotypes.txt \
       --covar discrete_covariates.txt \
       --qcovar continuous_covariates.txt \
       --out mydata \
       --thread-num 10 --maf 0.01 --autosome --remove exclude.txt

#Draw plots
Rscript qqman_scripts.R
