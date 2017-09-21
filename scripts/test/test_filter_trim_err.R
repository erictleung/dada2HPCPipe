# Load package
cat("Loading dada2HPCPipe and other packages...\n")
cat("Loading dada2HPCPipe package...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe")
cat("Loading dada2 package...\n")
library(dada2); packageVersion("dada2")
cat("Loading phyloseq package...\n")
library(phyloseq); packageVersion("phyloseq")
cat("Loading ggplot2 package...\n")
library(ggplot2); packageVersion("ggplot2")

# Variables
mothur_map <- "mothur_mapping.txt"
data <- "../../test_data"
temp_results <- "results"
step_results_file <- file.path(temp_results, "dada2_post_filter_errors.RData")
plot_dir <- "plots"
error_f_plot <- file.path(plot_dir, "forward_errors.png")
error_r_plot <- file.path(plot_dir, "reverse_errors.png")
truncation <- c(240, 160)
filter_dir <- "filtered"

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

# Learn error rates
errs <- do_error_learn(out$filtFs, out$filtRs)

# Get and plot errors learned
err_plot_f <- plotErrors(errs$err_f, nominalQ = TRUE)
err_plot_r <- plotErrors(errs$err_r, nominalQ = TRUE)
ggsave(error_f_plot, err_plot_f, width = 7, height = 5)
ggsave(error_r_plot, err_plot_r, width = 7, height = 5)

# Save errors and other information to be used in pipeline
dir.create(temp_results) # Place to put intermediate files
save(mothur_map, out, errs, file = step_results_file)
