# Title:
#   R Development Environment Setup
# Description:
#   This script checks your R environment to be compatible with the DADA2
#   pipeline.

# Check R version
R_min_version <- "3.4.0"
R_version <- paste0(R.Version()$major, ".", R.Version()$minor)
ifelse(compareVersion(R_version, R_min_version) < 0,
       message("R version looks okay:\n", version$major, ".", version$minor),
       stop(paste("You need an R version >", R_min_version, "\n"))

# Install Bioconductor, Version 3.5
source("https://bioconductor.org/biocLite.R")
biocLite()
