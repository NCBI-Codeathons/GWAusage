#!/bin/bash

module load R/3.6.0-mkl
PATH=/pylon5/brz3a1p/wis29/gcta_1.93.0beta/:$PATH

# Dependancies
#	- PLINK 1.9

#Format genotype data

# Check input parameters
if [ -z "$1" ]; then
	echo "Usage: input_filtering.sh <genotype_data> <maf>"
	exit 0
else
	# genotype data
	GENOTYPE_DATA=$1
fi

# minimum allele frequency
if [ -z "$2" ]; then
	echo "MAF is set to 0.01 by default";
	MAF=0.01
else 
	MAF=$2
fi

# Check the format of genotype data
geno_dirname=$(dirname -- "$GENOTYPE_DATA")
geno_filename=$(basename -- "$GENOTYPE_DATA")
geno_ext="${geno_filename##*.}"
geno_basename=${geno_filename%.*}

if [ "$geno_ext" = "bed" ] || [ "$geno_ext" = "BED" ]; then
	plink --noweb --bfile ${geno_dirname}/${geno_basename} --maf $MAF --autosome --make-bed --out ${geno_dirname}/${geno_basename}
else
	# if genotype data is in vcf format, convert it to plink ped/map format
	if [ "$geno_ext" = "vcf" ] || [ "$geno_ext" = "VCF" ]; then
		plink --noweb --vcf $GENOTYPE_DATA --recode --out ${geno_dirname}/${geno_basename}
	elif [ "$geno_ext" != "map" ] && [ "$geno_ext" != "MAP" ]; then
		echo "Invalid format for genotype data"
		exit 0
	fi
	plink --noweb --file ${geno_dirname}/${geno_basename} --maf $MAF --autosome --make-bed --out ${geno_dirname}/${geno_basename}
fi

#Perform stepwise regression
Rscript regression.R

#Calculate genetic relatedness matrix
gcta64 --bfile mydata --autosome --make-grm --thread-num 10 --out mydata_matrix

#Perform GWAS
gcta64 --mlma --bfile mydata --grm mydata \
        --pheno phenotypes.txt \
        --covar disc_cov.txt \
        --qcovar cont_cov.txt \
        --out mydata \
        --thread-num 10 --maf 0.01 --autosome

#Draw plots
Rscript qqman_scripts.R

#Generate clump file
plink --bfile ../NAPS2 --clump ../*.mlma --clump-p1 1e-5 --clump-r2 0 --clump-kb 500 --out locus --clump-field p --clump-p2 1

#Get snips from clump file
awk '{print $3}' locus.clumped > index_snps.txt

