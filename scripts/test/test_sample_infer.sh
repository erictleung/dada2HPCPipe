#!/usr/bin/env bash

# SBATCH --job-name=test_sample_infer
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Read in data amd check quality
date
time Rscript test_sample_infer.R