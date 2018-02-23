#!/usr/bin/env bash

#SBATCH --job-name=2_test_filter_trim_err
#SBATCH --output=out/2_test_filter_trim_err.out
#SBATCH --error=error/2_test_filter_trim_err.err
#SBATCH --time=03:30:00
#SBATCH --partition=exacloud

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
