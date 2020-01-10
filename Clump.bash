#!/bin/bash

OUTPUT_DIR=../../temp
GENO_BASENAME="genotype_data"

#Generate clump file
plink --bfile ${OUTPUT_DIR}/${GENO_BASENAME} --clump ${OUTPUT_DIR}/*.mlma --clump-p1 1e-5 --clump-r2 0 --clump-kb 500 --out ${OUTPUT_DIR}/locus --clump-field p --clump-p2 1

#Get snips from clump file
awk '{print $3}' ${OUTPUT_DIR}/locus.clumped > ${OUTPUT_DIR}/index_snps.txt