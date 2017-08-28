#' Read in Data Step
#'
#' Takes in strings for paths and returns a list to further manipulate in
#' downstream steps.
#'
#' @param map_file string with path to mapping file
#' @param data_path string with directory of samples
#'
#' @return Returns list with four elements:
#'
#' \describe{
#'   \item{\code{map}}{the mapping file}
#'   \item{\code{seq_f}}{forward sequencing sample paths}
#'   \item{\code{seq_r}}{reverse sequencing sample paths}
#'   \item{\code{seq_names}}{samples names for sequence samples}
#' }
#'
#' @export
#'
#' @examples
#' example_map <- "mapping.txt"
#' example_data <- "sequences"
#' input_files <- do_input_step(example_map, example_data)
do_input_step <- function(map_file, data_path) {
    raw_meta <- import_qiime_sample_data(map_file) # Read in mapping file
    sequence_data_paths <- read_in_data(data_path) # Import sample information

    list(map = raw_meta,
         seq_f = sequence_data_paths$forward,
         seq_r = sequence_data_paths$reverse,
         seq_names = sequence_data_paths$samples)
}

do_quality_step <- function() {

}

do_derep_step <- function() {

}

do_sample_infer_step <- function() {

}

do_rm_chimera_step <- function() {

}

do_track_dada2 <- function() {

}

do_taxonomy_step <- function() {

}
