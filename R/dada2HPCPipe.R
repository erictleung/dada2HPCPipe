#' dada2HPCPipe: DADA2 HPC Workflow Wrapper
#'
#' 16S rRNA microbiome data analysis workflow using DADA2 and R on a high
#' performance cluster using Slurm. The functions here are wrappers around the
#' DADA2 functions in order to more efficiently use on a cluster. The functions
#' break down the workflow into parts based on stopping points that require a
#' user's input for the next steps.
#'
#' @references Callahan, Benjamin J., et al. "DADA2: high-resolution sample
#'   inference from Illumina amplicon data." Nature Methods 13.7 (2016):
#'   581-583. \url{http://dx.doi.org/10.1038/nmeth.3869}
#' @references DADA2 GitHub page \url{https://github.com/benjjneb/dada2}
#' @references Callahan, Ben J., et al. "Bioconductor workflow for microbiome
#'   data analysis: from raw reads to community analyses." F1000Research 5
#'   (2016). \url{http://dx.doi.org/10.12688/f1000research.8986.2}
#' @references DADA2 Homepage \url{http://benjjneb.github.io/dada2/}
#'
#' @import dada2
#' @importFrom magrittr "%>%"
#' @importFrom phyloseq sample_data import_qiime_sample_data
#' @importFrom dplyr filter_
#' @importFrom ggplot2 ggsave
"_PACKAGE"
