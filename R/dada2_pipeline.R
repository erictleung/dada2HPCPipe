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

#' Plot Quality Profile Step
#'
#' @param for_seqs character vector of paths for the forward sequencing samples
#' @param rev_seqs character vector of paths for the reverse sequencing samples
#' @param w width of the output figure
#' @param h height of the output figure
#'
#' @export
#'
#' @examples
#' sample_f <- c("s001_R001.fastq", "s002_R001.fastq")
#' sample_r <- c("s001_R002.fastq", "s002_R002.fastq")
#' do_quality_step(sample_f, sample_r)
do_quality_step <- function(for_seqs, rev_seqs, w = 7, h = 5) {
    # Plot all samples if there aren't too many
    if (length(for_seqs) < 12) {
        # Generate quality plots for all samples
        for_plots <- plotQualityProfile(for_seqs)
        rev_plots <- plotQualityProfile(rev_seqs)
    } else {
        random_samples <- for_seqs %>%
             length() %>%
             sample(size = 12, replace = FALSE)
        cat("Plotting these twelve samples:\n", random_samples)

        # Generate quality plots for only twelve forward and reverse
        for_plots <- plotQualityProfile(for_seqs[random_samples])
        rev_plots <- plotQualityProfile(rev_seqs[random_samples])
    }

    ggsave("forward_quality.png", for_plots, width = w, height = h)
    ggsave("reverse_quality.png", rev_plots, width = w, height = h)
}

#' Dereplication Step
#'
#' For DADA2 to work efficiently, samples sequences are dereplicated into
#' "unique sequences" with corresponding counts of these sequences.
#'
#' This step reduces compute time by eliminating redundant comparisons.
#'
#' **Note**: DADA retains quality information associated with each unique
#' sequence. It averages the sequences for each unique sequence. These quality
#' scores are used in the error model.
#'
#' It is intended to take the output from `filterAndTrim()` into this function.
#'
#' @param filt_Fs forward filtered reads
#' @param filt_Rs reverse filtered reads
#'
#' @return Returns list of errors
#'
#' \describe{
#'   \item{\code{err_f}}{error rates learned for forward sequences}
#'   \item{\code{err_r}}{error rates learned for reverse sequences}
#' }
#'
#' @export
#'
#' @references See "Dereplication"
#'   \url{http://benjjneb.github.io/dada2/tutorial.html#dereplication}
#'
#' @examples
#' example_map <- "mapping.txt"
#' example_data <- "sequences"
#' input_files <- do_input_step(example_map, example_data)
#' errors <- do_derep_step(input_files$seq_f, input_files$seq_r)
do_derep_step <- function(filt_Fs, filt_Rs) {
    # Learn errors for DADA2 denoising model
    err_f <- learnErrors(filt_Fs, multithread = TRUE)
    err_r <- learnErrors(filt_Rs, multithread = TRUE)
    list(err_f = err_f, err_r = err_r)
}

do_sample_infer_step <- function(filt_Fs, err_f, filt_Rs, err_r) {
    # Dereplicate reads for efficiency
    derepFs <- derepFastq(filt_Fs, verbose = TRUE)
    derepRs <- derepFastq(filt_Rs, verbose = TRUE)

    # Main sample inference step of DADA2
    dadaFs <- dada(derepFs, err = err_f, multithread = TRUE)
    dadaRs <- dada(derepRs, err = err_r, multithread = TRUE)

    # Merge paired ends
    mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs, verbose = TRUE)
    mergers
}


do_taxonomy_step <- function(mergers, chim_method = "consensus", ref_db) {
    # Make sequence table with rows = samples and cols = "OTUs"
    seqtab <- makeSequenceTable(mergers)

    cat("Here's a distribution table of sequence lengths:")
    seqtab %>% getSequences %>% nchar %>% table %>% print

    # Remove chimeras based on default consensus method
    seqtab_nochim <- removeBimeraDenovo(seqtab, method = chim_method,
                                        multithread = TRUE, verbose = TRUE)

    cat("Fraction of sequences with chimeras removed:")
    print(sum(seqtab_nochim)/sum(seqtab))

    taxa <- assignTaxonomy(seqtab_nochim, ref_db, multithread=TRUE)
    taxa
}

do_track_dada2 <- function(out, dadaFs, getN, mergers, seqtab, seqtab.nochim,
                           sample.names) {
    # Create data frame with metrics along the workflow
    track <- cbind(out, sapply(dadaFs, getN), sapply(mergers, getN),
                   rowSums(seqtab), rowSums(seqtab.nochim))
    colnames(track) <- c("input", "filtered", "denoised", "merged",
                         "tabled", "nonchim")
    rownames(track) <- sample.names
}
