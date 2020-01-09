#!/bin/bash

OUTPUT_DIR=../../temp
GENO_BASENAME="genotype_data"

#Perform GWAS
gcta64 --mlma --bfile ${OUTPUT_DIR}/${GENO_BASENAME} --grm ${OUTPUT_DIR}/{GENO_BASENAME} \
        --pheno phenotypes.txt \
        --covar disc_cov.txt \
        --qcovar cont_cov.txt \
        --out ${OUTPUT_DIR}/${GENO_BASENAME} \
        --thread-num 10 --maf 0.01 --autosome