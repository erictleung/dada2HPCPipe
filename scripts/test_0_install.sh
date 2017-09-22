#!/usr/bin/env bash

# SBATCH --job-name=test_dada2_pipe
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_0_install.sh
RSCRIPT=src/test_install.R

# Test correct installation of dada2HPCPipe
echo "Title: Testing dada2HPCPipe Installation"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
