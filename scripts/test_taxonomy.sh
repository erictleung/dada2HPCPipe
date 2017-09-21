#!/usr/bin/env bash

# SBATCH --job-name=test_taxonomy
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Assign taxonomy for inferred results
date
time Rscript src/test_taxonomy.R
