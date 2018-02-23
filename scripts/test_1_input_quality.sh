#!/usr/bin/env bash

#SBATCH --job-name=1_test_input_quality
#SBATCH --output=out/1_test_input_quality.out
#SBATCH --error=error/1_test_input_quality.err
#SBATCH --time=01:00:00
#SBATCH --partition=exacloud

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
