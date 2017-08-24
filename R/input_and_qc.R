# Required packages for functions to work
require(dada2)

#' Read in Sequence Data
#'
#' This function reads in appropriate sequence data from a give directory. It
#' returns a list object that has the paths to all the samples and sample
#' names.
#'
#' @param path string with path to samples
#'
#' @return list with three elements: forward, reverse, and samples
#' @export
#'
#' @examples
#' path_to_samples <- "~/Samples/"
#' sample.paths <- read_in_data(path_to_samples)
read_in_data <- function(path) {
    fns <- list.files(path)  # List of files in path

    # Find only .fastq/.fastq.gz files and sort alphabetically
    fastqs <- fns[grepl(".fastq(.gz)?$", fns)] %>%
        sort()

    # Split up forward and reverse sequences
    fnFs <- fastqs[grepl("_R1", fastqs)]  # Forward sequences
    fnRs <- fastqs[grepl("_R2", fastqs)]  # Reverse sequences

    # Extract sample names
    sample.names <- sapply(X = strsplit(fnFs, "_"), FUN = `[`, 1)

    # Give path names
    fnFs <- file.path(path, fnFs)
    fnRs <- file.path(path, fnRs)

    list(forward = fnFs, reverse = fnRs, samples = sample.names)
}

# Title:
#   Filter and Trim
# Description:
#   Filters and trims paired forward and reverse .fastq files
# Input:
#   Sample path
# Output:
#   New filtered reads into filtered/ directory
# To Do:
#    - Variable parameters for fastqPairedFilter()


#' Filter and Trim Sample Sequences
#'
#' Filteres and trims paired forward and reverse *.fastq files
#'
#' @param samplNames vector of sample names
#' @param fnFs vector of paths to forward samples
#' @param fnRs vector of paths to reverse samples
#' @param outDir specified directory to output filtered reads
#' @param truncLen a vector with two elements, the first being the truncated
#'   length for the forward reads and the second being the truncated length for
#'   the reverse reads
#'
#' @return new filtered reads put into the filtered/ directory
#' @export
#'
#' @examples
filter_and_trim <- function(samplNames, fnFs, fnRs, outDir, truncLen) {
    if (!file_test("-d", outDir)) dir.create(outDir)
    filtFs <- file.path(outDir, paste0(samplNames, "_F_filt.fastq.gz"))
    filtRs <- file.path(outDir, paste0(samplNames, "_R_filt.fastq.gz"))
    for (i in seq_along(fnFs)) {
        fastqPairedFilter(c(fnFs[i], fnRs[i]), c(filtFs[i], filtRs[i]),
                          truncLen = truncLen,
                          maxN = 0,
                          maxEE = c(2,2),
                          truncQ = 2,
                          rm.phix = TRUE,
                          compress = TRUE,
                          verbose = TRUE)
    }
    list(filtRs = filtRs, filtFs = filtFs)
}
