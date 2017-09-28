# Title:
#   Test Pipeline Tracking

# Load package
cat("Loading dada2HPCPipe and other packages...\n")
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe"); cat("\n")

# Variables
temp_results <- "results"
step_results_file <- file.path(temp_results, "dada2_post_filter_errors.RData")
sample_infer_file <- file.path(temp_results, "dada2_post_sample_infer.RData")
seqresults <- file.path(temp_results, "sequence_table.rds")
tracked_results <- file.path(temp_results, "track.rds")

# Load data from inference step
load(step_results_file)
load(sample_infer_file)
seqtab <- readRDS(seqresults)

# Track resuts
track <- do_track_dada2(out, dada_result$dadaFs, dada_result$mergers,
                        seqtab$seqtab, seqtab$seqtab_nochim, sample_names)
head(track)

# Save sequence table
cat("Tracking table...\n")
saveRDS(tracked, file = )
cat("Finished writing!\n")
