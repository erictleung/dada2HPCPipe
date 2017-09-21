#!/usr/bin/env bash

# SBATCH --job-name=test_dada2_pipe
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Test correct installation of dada2HPCPipe
echo "Title: Testing dada2HPCPipe Installation"
echo "Script: test_0_install.sh"
date
echo ""
time Rscript src/test_install.R
