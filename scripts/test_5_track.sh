#!/usr/bin/env bash

#SBATCH --job-name=5_test_track
#SBATCH --output=out/5_test_track.out
#SBATCH --error=error/5_test_track.err
#SBATCH --time=01:30:00
#SBATCH --partition=exacloud

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
