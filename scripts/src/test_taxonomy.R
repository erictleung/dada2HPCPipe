# Load package
cat("Loading dada2HPCPipe and other packages...\n")
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe"); cat("\n")

# Variables
temp_results <- "results"
sample_infer_file <- file.path(temp_results, "dada2_post_sample_infer.RData")
refdb <- "../refs/rdp_train_set_16.fa.gz"
seqresults <- file.path(temp_results, "sequence_table.rds")

# Load data from inference step
load(sample_infer_file)

# Construct sequence table
seqtab <- do_taxonomy_step(dada_result$mergers, ref_db = refdb)

# Save sequence table
cat("Writing out sequence table...\n")
saveRDS(seqtab, file = seqresults)
cat("Finish writing!\n")
