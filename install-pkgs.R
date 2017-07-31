# Title:
#   R Development Environment Setup
# Description:
#   This script checks your R environment to be compatible with the DADA2
#   pipeline.
#
#   Software versions:
#       - R (>3.4.0)
#       - Bioconductor (>3.5)

# Set minimum R version and find existing R version
R_min_version <- "3.4.0"
R_version <- paste0(R.Version()$major, ".", R.Version()$minor)

# Compare and give feedback on steps to take, given found R version
if (compareVersion(R_version, R_min_version) >= 0) {
    message("R version looks okay:\n", version$major, ".", version$minor)
} else {
    stop(paste("You need an R version >", R_min_version, "\n"))
}

# Install Bioconductor (Current Version 3.5)
source("https://bioconductor.org/biocLite.R")
biocLite()
