#!/usr/bin/env bash

#SBATCH --job-name=4_test_taxonomy
#SBATCH --output=out/4_test_taxonomy.out
#SBATCH --error=error/4_test_taxonomy.err
#SBATCH --time=01:30:00
#SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_4_taxonomy.sh
RSCRIPT=src/test_4_taxonomy.R

# Assign taxonomy for inferred results
echo "Title: Construct Sequence Table, Remove Chimeras, and Assign Taxonomy"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
