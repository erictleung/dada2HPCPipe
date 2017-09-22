#!/usr/bin/env bash

# SBATCH --job-name=test_taxonomy
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_4_taxonomy.sh
RSCRIPT=src/test_taxonomy.R

# Assign taxonomy for inferred results
echo "Title: Construct Sequence Table, Remove Chimeras, and Assign Taxonomy"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
