# Title:
#   Test Package Installation
# Description:
#   This script simply tests the loading of the package into R to make sure it
#   does so without any errors

# Load library
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe"); cat("\n")
cat("No errors!\n")
