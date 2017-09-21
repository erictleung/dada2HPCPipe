#!/usr/bin/env bash

# SBATCH --job-name=test_dada2_pipe
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud

# Test correct installation of dada2HPCPipe
date
time Rscript test_install.R
