#!/usr/bin/env bash

# SBATCH --job-name=test_filter_trim_err
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_2_filter_trim_err.sh
RSCRIPT=src/test_2_filter_trim_err.R

# Read in data amd check quality
echo "Title: Test Filter, Trim, and Error Learning"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
