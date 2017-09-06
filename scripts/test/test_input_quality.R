# Load package
cat("Loading dada2HPCPipe and phyloseq packages...\n")
library(dada2HPCPipe); packageVersion("dada2HPCPipe")
library(phyloseq); packageVersion("phyloseq")

# Variables
meta <- "../../test_data/mouse.dpw.metadata"
mothur_map <- "mothur_mapping.txt"
data <- "../../test_data"

# Create sample mapping file
cat("Creating sample mapping file...\n")
mothur_meta <- read.csv(
    file = meta,
    sep = "\t",
    stringsAsFactors = FALSE)
samples.out <- mothur_meta[["group"]]
subject <- sapply(strsplit(samples.out, "D"), `[`, 1)
gender <- substr(subject, 1, 1)
gsubject <- substr(subject, 2, 999)
day <- as.integer(sapply(strsplit(samples.out, "D"), `[`, 2))
linker <- "YATGCTGCCTCCCGTAGGAGT"
barcode <- sapply(1:length(samples.out), function(X) {
    paste0(sample(c("A", "C", "T", "G"), 12, replace = TRUE), collapse = "")
})
description <- "Sample Data"

# Put mapping file together
samdf <- data.frame(Linker = linker, Barcode = barcode, Subject = subject,
                    Gender = gender, Day = day, Description = description)

# Specify timing and reorganize columns
samdf$When <- "Early"
samdf$When[samdf$Day > 100] <- "Late"
samdf[["#SampleID"]] <- samples.out
samdf <- samdf[c("#SampleID", "Linker", "Barcode", "Subject", "Gender", "Day",
                 "When", "Description")]

# Write out file and read in file like the function assumes
write.csv(samdf, mothur_map, row.names = FALSE)
cat("Importing mapping file...\n")
input <- do_input_step(mothur_map, data);
cat("Read in data successfully!\n")
