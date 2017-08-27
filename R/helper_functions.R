#' Extract Sample IDs
#'
#' In a vector of sequence labels, return a vector of just the sample IDs with
#' the format of "s" followed by three digits.
#'
#' @param sample_list vector of sample names
#'
#' @return vector of sample IDs
#'
#' @examples
#' example_samples <- c("lane1-s216-index-GTTTCTGCT-s216.fastq.gz",
#'                      "lane1-s217-index-CACGATGGA-s217.fastq.gz")
#' extract_sample_id(example_samples)
extract_sample_id <- function(sample_list) {
    gsub(".*(s\\d{3}).*", "\\1", sample_list, perl = TRUE)
}

#' Filter Samples by ID
#'
#' Given a vector of sample names or labeling that has a sample ID, this
#' function will filter the sample names by IDs.
#'
#' @param ids vector of ID numbers or labels
#' @param sample_list vector of string sample names
#'
#' @return vector of original sample vector but filtered for certain IDs
#'
#' @examples
#' example_samples <- c("lane1-s216-index-GTTTCTGCT-s216_L001_R1_001.fastq.gz",
#'                      "lane1-s217-index-CACGATGGA-s217_L001_R1_001.fastq.gz")
#' example_ids <- c("s216")
#' filter_by_id(example_ids, example_samples)
filter_by_id <- function(ids, sample_list) {
    boolean_keep_ids <- extract_sample_id(sample_list) %in% ids
    sample_list[boolean_keep_ids]
}
