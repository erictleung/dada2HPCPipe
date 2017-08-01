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
    message("R version looks okay: ", version$major, ".", version$minor)
} else {
    stop(paste("You need an R version >", R_min_version, "\n"))
}

# Install Bioconductor (Current Version 3.5)
source("https://bioconductor.org/biocLite.R")
biocLite()

# Minimum DADA2 version that should be used
dada_min_vers <- "1.4.0"

# Check DADA2 version, if installed already
installed_dada2 <- tryCatch({
    packageVersion("dada2")
}, error = function(e) {
    message("DADA2 isn't installed. Will try to install now...")
    return(0)
})

# Install recent version of DADA2 if needed
if (installed_dada2 < dada_min_vers) {
    biocLite("dada2")
} else {
    message("DADA2 version is okay.")
}
