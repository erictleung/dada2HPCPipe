# Description:
#   This step performs a dereplication step and the main denoising step of the
#   DADA2 algorithm pipeline.
#
#   The results of both steps are saved in a file in the results/ directory.

# Load package
cat("Loading dada2HPCPipe and other packages...\n")
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe"); cat("\n")
cat("Loading dada2 package...\n")
library(dada2); packageVersion("dada2"); cat("\n")
cat("Loading phyloseq package...\n")
library(phyloseq); packageVersion("phyloseq"); cat("\n")

# Variables
temp_results <- "results"
step_results_file <- file.path(temp_results, "dada2_post_filter_errors.RData")
sample_infer_file <- file.path(temp_results, "dada2_post_sample_infer.RData")

# Load data from previous step
load(step_results_file)

# Perform dereplication and denoising steps
dada_result <- do_sample_infer_step(out$filtFs, errs$err_f,
                                    out$filtRs, errs$err_r,
                                    input$seq_names)

# Save results of file
cat("Saving results of dereplication and sample inference\n")
save(dada_result, file = sample_infer_file)
