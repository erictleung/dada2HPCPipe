# Title:
#   Test Filtering and Trimming Functionality
# Description:
#   This script filters, trims the sample sequences based on truncation input,
#   and then learns the error rates from these new sample sequences.
# Input:
#   - metadata/mothur_mapping.txt
# Output:
#   - Plots
#       - results/forward_errors.png - plot of learned errors for the forward
#         sequences
#       - results/reverse_errors.png - plot of learned errors for the reverse
#         sequence
#   - Saved Variables
#       - results/sample_names.rds - vector of sample names
#       - results/sample_seq_for.rds - vector of forward sequence paths
#       - results/sample_seq_rev.rds - vector of reverse sequence paths
#       - results/mapping_file.rds - mapping file of metadata for data
#       - results/filtered_samples_for.rds
#       - results/filtered_samples_rev.rds
#       - results/learned_errs.rds

# Setup ------------------------------------------

# Load package
cat("Loading dada2HPCPipe and other packages...\n")
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe"); cat("\n")
cat("Loading dada2 package...\n")
library(dada2); packageVersion("dada2"); cat("\n")
cat("Loading phyloseq package...\n")
library(phyloseq); packageVersion("phyloseq"); cat("\n")
cat("Loading ggplot2 package...\n")
library(ggplot2); packageVersion("ggplot2"); cat("\n")

# Variables
metadata_dir <- "metadata"
mothur_map <- file.path(metadata_dir, "mothur_mapping.txt")
data <- "test_data"
temp_results <- "results"
plot_dir <- "results"
truncation <- c(240, 160)
filter_dir <- "filtered"

# Output Variables
error_f_plot <- file.path(plot_dir, "forward_errors.png")
error_r_plot <- file.path(plot_dir, "reverse_errors.png")
output_sample_names <- file.path(temp_results, "sample_names.rds")
output_seq_for <- file.path(temp_results, "sample_seq_for.rds")
output_seq_rev <- file.path(temp_results, "sample_seq_rev.rds")
output_map <- file.path(temp_results, "mapping_file.rds")
output_filter_f <- file.path(temp_results, "filtered_samples_for.rds")
output_filter_r <- file.path(temp_results, "filtered_samples_rev.rds")
output_errs <- file.path(temp_results, "learned_errs.rds")

# Read Data and Process --------------------------

# Read in file like the function assumes
cat("Importing mapping file...\n")
input <- do_input_step(mothur_map, data);
cat("Read in data successfully!\n")

# Filter and trim sequences
out <- filter_and_trim(input$seq_names,
                       input$seq_f,
                       input$seq_r,
                       filter_dir,
                       truncation)

# Take a look at filtering work
cat("Take look at the filtered and trimming samples\n")
head(out)

# Learn Error Rates ------------------------------

# Learn error rates
errs <- do_error_learn(out$filtFs, out$filtRs)

# Get and plot errors learned
err_plot_f <- plotErrors(errs$err_f, nominalQ = TRUE)
err_plot_r <- plotErrors(errs$err_r, nominalQ = TRUE)
if (!file_test("-d", plot_dir)) dir.create(plot_dir)
ggsave(error_f_plot, err_plot_f, width = 7, height = 5)
ggsave(error_r_plot, err_plot_r, width = 7, height = 5)

# Write Out Results ------------------------------

# Save errors and other information to be used in pipeline
dir.create(temp_results) # Place to put intermediate files
saveRDS(input$seq_names, file = output_sample_names)
saveRDS(input$seq_f, file = output_seq_for)
saveRDS(input$seq_r, file = output_seq_rev)
saveRDS(input$map, file = output_map)
saveRDS(out$filtFs, file = output_filter_f)
saveRDS(out$filtRs, file = output_filter_r)
saveRDS(errs, file = output_errs)
