#!/bin/bash

# Dependancies
#	- PLINK 1.9

# fixed path and input filename
INPUT_DIR=../../input
OUTPUT_DIR=../../temp
GENO_BASENAME="genotype_data"
# minimum allele frequency
MAF=0.01 

if [ -f "${INPUT_DIR}/${GENO_BASENAME}.vcf" ]; then
    vcf_ifile=${INPUT_DIR}/${GENO_BASENAME}.vcf
fi
if [ -f "${INPUT_DIR}/${GENO_BASENAME}.vcf.gz" ]; then
	vcf_ifile=${INPUT_DIR}/${GENO_BASENAME}.vcf.gz
fi
if [ ! -z "$vcf_ifile" ]; then
	echo "Genotype data is in the format of vcf. Convert it to plink map"
	plink --noweb --vcf $vcf_ifile --recode --out ${OUTPUT_DIR}/${GENO_BASENAME}
fi

if [ -f "${INPUT_DIR}/${GENO_BASENAME}.map" ]; then
	map_ifile=${INPUT_DIR}/${GENO_BASENAME}
elif [ -f "${OUTPUT_DIR}/${GENO_BASENAME}.map" ]; then
	map_ifile=${OUTPUT_DIR}/${GENO_BASENAME}
fi
if [ ! -z "$map_ifile" ]; then
	echo "Genotype data is in the format of map. Run plink"
	plink --noweb --file $map_ifile --maf $MAF --autosome --make-bed --out ${OUTPUT_DIR}/${GENO_BASENAME}
fi

if [ -f "${INPUT_DIR}/${GENO_BASENAME}.bed" ]; then
	echo "Genotype data is in the format of bed. Run plink"
    plink --noweb --bfile ${INPUT_DIR}/${GENO_BASENAME} --maf $MAF --autosome --make-bed --out ${OUTPUT_DIR}/${GENO_BASENAME}
fi
