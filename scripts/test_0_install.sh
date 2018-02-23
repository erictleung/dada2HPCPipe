#!/usr/bin/env bash

#SBATCH --job-name=0_test_install
#SBATCH --output=out/0_test_install.out
#SBATCH --error=error/0_test_install.err
#SBATCH --time=00:30:00
#SBATCH --partition=exacloud

# Script variables
SCRIPTNAME=test_0_install.sh
RSCRIPT=src/test_0_install.R

# Test correct installation of dada2HPCPipe
echo "Title: Testing dada2HPCPipe Installation"
echo "Script: ${SCRIPTNAME}"
echo "R Script: ${RSCRIPT}"
date
echo ""
time Rscript $RSCRIPT
