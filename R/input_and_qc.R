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
#' sample_paths <- read_in_data(path_to_samples)
read_in_data <- function(path) {
    fns <- list.files(path)  # List of files in path

    # Find only .fastq/.fastq.gz files and sort alphabetically
    fastqs <- fns[grepl(".fastq(.gz)?$", fns)] %>%
        sort()

    # Split up forward and reverse sequences
    fnFs <- fastqs[grepl("_R1", fastqs)]  # Forward sequences
    fnRs <- fastqs[grepl("_R2", fastqs)]  # Reverse sequences

    # Extract sample names
    sample_names <- sapply(X = strsplit(fnFs, "_"), FUN = `[`, 1)

    # Give path names
    fnFs <- file.path(path, fnFs)
    fnRs <- file.path(path, fnRs)

    list(forward = fnFs, reverse = fnRs, samples = sample_names)
}

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

#' Filter Filtered Samples by Mapping File
#'
#' This function filteres out samples based on some filter or metric
#'
#' @param map_file a mapping phyloseq object
#' @param filter a character string with query to filter
#' @param id_col_name a character string containing the ID column name in the
#'   mapping file
#' @param samples a character vector
#'
#' @return list two attributes filtFs are paths to forward filtered sequences
#'   and filtRs are paths to reverse filtered sequences
#' @export
#'
#' @examples
#' example_forward <- c("lane1-s216-index-GTTTCTGCT-s216_L001_R1_001.fastq.gz",
#'                      "lane1-s217-index-CACGATGGA-s217_L001_R1_001.fastq.gz")
#' example_reverse <- c("lane1-s216-index-GTTTCTGCT-s216_L001_R2_001.fastq.gz",
#'                      "lane1-s217-index-CACGATGGA-s217_L001_R2_001.fastq.gz")
#' sample_names <- c("lane1-s216-index-CACGATGGA-s216",
#'                   "lane1-s217-index-CACGATGGA-s217")
#' samples <- list(forward = example_forward,
#'                 reverse = example_reverse,
#'                 samples= sample_names)
#' example_ids <- c("s216")
#' mapping <- data.frame(X.SampleID = c("s216"),
#'                       BarcodeSequence = c("AGTGATGC"),
#'                       Description = "Wanted sample")
#' filter_samples(map_file = mapping,
#'                filter = "BarcodeSequence == 'AGTGATGC'",
#'                id_col_name = "X.SampleID",
#'                samples = samples)
filter_samples <- function(map_file, filter, id_col_name, samples) {
    # Filter mapping file based on filtering query
    filtered_all_map <- map_file %>%
        data.frame %>%
        filter_(filter) %>%
        sample_data() # Convert back to phyloseq object

    # Filter sample list by sample IDs in the mapping file
    kept_samples <- filtered_all_map[[id_col_name]]
    filt_samples <- lapply(samples, function(x) filter_by_id(kept_samples, x))

    list(map = filtered_all_map, samples = filt_samples)
}
