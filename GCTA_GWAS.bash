#!/bin/bash

OUTPUT_DIR=../../temp

#Perform GWAS
gcta64 --mlma --bfile ${OUTPUT_DIR}/mydata --grm ${OUTPUT_DIR}/mydata \
        --pheno phenotypes.txt \
        --covar disc_cov.txt \
        --qcovar cont_cov.txt \
        --out ${OUTPUT_DIR}/mydata \
        --thread-num 10 --maf 0.01 --autosome