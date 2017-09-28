#!/usr/bin/env bash

# SBATCH --job-name=test_sample_infer
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

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
