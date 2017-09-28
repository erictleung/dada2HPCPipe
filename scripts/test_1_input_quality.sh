#!/usr/bin/env bash

# SBATCH --job-name=test_input_quality
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_1_input_quality.sh
RSCRIPT=src/test_1_input_quality.R

# Read in data amd check quality
echo "Title: Test Reading in Data and Assessing Quality"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
