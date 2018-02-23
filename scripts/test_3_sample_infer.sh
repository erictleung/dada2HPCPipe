#!/usr/bin/env bash

#SBATCH --job-name=3_test_sample_infer
#SBATCH --output=out/3_test_sample_infer.out
#SBATCH --error=error/3_test_sample_infer.err
#SBATCH --time=03:30:00
#SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_3_sample_infer.sh
RSCRIPT=src/test_3_sample_infer.R

# Read in data amd check quality
echo "Title: Test Dereplication and Denoising Step"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
