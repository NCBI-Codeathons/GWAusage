#!/bin/bash

#module load R/3.6.0-mkl
#PATH=/pylon5/brz3a1p/wis29/gcta_1.93.0beta/:$PATH
​
# fixed path and input filename
INPUT_DIR=../../input
OUTPUT_DIR=../../temp
GENO_BASENAME="genotype_data"
# minimum allele frequency
MAF=0.01 
​
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
​
if [ -f "${INPUT_DIR}/${GENO_BASENAME}.map" ]; then
	map_ifile=${INPUT_DIR}/${GENO_BASENAME}
elif [ -f "${OUTPUT_DIR}/${GENO_BASENAME}.map" ]; then
	map_ifile=${OUTPUT_DIR}/${GENO_BASENAME}
fi
if [ ! -z "$map_ifile" ]; then
	echo "Genotype data is in the format of map. Run plink"
	plink --noweb --file $map_ifile --maf $MAF --autosome --make-bed --out ${OUTPUT_DIR}/${GENO_BASENAME}
fi
​
if [ -f "${INPUT_DIR}/${GENO_BASENAME}.bed" ]; then
	echo "Genotype data is in the format of bed. Run plink"
    plink --noweb --bfile ${INPUT_DIR}/${GENO_BASENAME} --maf $MAF --autosome --make-bed --out ${OUTPUT_DIR}/${GENO_BASENAME}
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
gcta64 --bfile temp/mydata --autosome --make-grm --thread-num 10 --out temp/mydata

#Perform GWAS
gcta64 --mlma --bfile temp/mydata --grm temp/mydata \
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

