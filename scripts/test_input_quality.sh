#!/usr/bin/env bash

# SBATCH --job-name=test_input_quality
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Read in data amd check quality
echo "Title: Test Reading in Data and Assessing Quality"
date
echo ""
time Rscript test_input_quality.R
