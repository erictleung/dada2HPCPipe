#!/usr/bin/env bash

# SBATCH --job-name=test_track
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_5_taxonomy.sh
RSCRIPT=src/test_5_track.R

# Assign taxonomy for inferred results
echo "Title: Track Reads Through Pipeline"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
