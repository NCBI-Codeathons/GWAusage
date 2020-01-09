#!/bin/bash

OUTPUT_DIR=../../temp

#Calculate genetic relatedness matrix
gcta64 --bfile ${OUTPUT_DIR}/mydata --autosome --make-grm --thread-num 10 --out ${OUTPUT_DIR}/mydata