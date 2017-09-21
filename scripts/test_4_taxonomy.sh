#!/usr/bin/env bash

# SBATCH --job-name=test_taxonomy
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Assign taxonomy for inferred results
echo "Title: Construct Sequence Table, Remove Chimeras, and Assign Taxonomy"
echo "Script: test_4_taxonomy.sh"
date
echo ""
time Rscript src/test_taxonomy.R
