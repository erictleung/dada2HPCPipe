#' dada2HPCPipe: DADA2 HPC Workflow Wrapper
#'
#' 16S rRNA microbiome data analysis workflow using DADA2 and R on a high
#' performance cluster using Slurm. The functions here are wrappers around the
#' DADA2 functions in order to more efficiently use on a cluster. The functions
#' break down the workflow into parts based on stopping points that require a
#' user's input for the next steps.
#'
#' @importFrom phyloseq sample_data
#' @importFrom dplyr filter_
#' @importFrom dada2 fastqPairedFilter
"_PACKAGE"
