#!/usr/bin/env bash

# SBATCH --job-name=test_dada2_pipe
# SBATCH --output=dada2_out.txt
# SBATCH --error=error.txt
# SBATCH --time=01:20:00
# SBATCH --partition=exacloud
# SBATCH --mail-type=END,FAIL
# SBATCH --mail-user=user@univ.edu

# Test correct installation of dada2HPCPipe
Rscript -e 'library(dada2HPCPipe);cat("No errors!\n")'
