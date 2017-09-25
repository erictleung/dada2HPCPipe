# Makefile to Automate Analyses and Setup
SHELL := /bin/bash

# Variables
SILVA_ZENODO=https://zenodo.org/record/824551
RDP16=https://zenodo.org/record/801828
RDP14=https://zenodo.org/record/158955
GREENGENES=https://zenodo.org/record/158955
CONDA_SHELL=https://repo.continuum.io/miniconda/
CONDA_SCRIPT=Miniconda2-latest-Linux-x86_64.sh

# Directories
REFS=refs
TEST_DL=scripts/download
TEST_DAT=scripts/test_data

setup : ## Setup development environment with Conda
	# Download and install Miniconda
	wget $(CONDA_SHELL)$(CONDA_SCRIPT)
	bash $(CONDA_SCRIPT)

	# Remove install file
	rm $(CONDA_SCRIPT)

condar : setup ## Install R and essential packages
	# Install R and relevant packages
	conda install r-essentials

install : ## Install and update dada2HPCPipe package in R
	Rscript -e 'if (!"devtools" %in% installed.packages()) install.packages(devtools);devtools::install_github("erictleung/dada2HPCPipe")'

dl-ref-dbs : ## Download 16S reference databases (SILVA,RDP,GG)
	mkdir $(REFS)
	wget $(SILVA_ZENODO)/files/silva_nr_v128_train_set.fa.gz -P $(REFS)
	wget $(SILVA_ZENODO)/files/silva_species_assignment_v128.fa.gz -P $(REFS)
	wget $(SILVA_ZENODO)/files/SILVA_LICENSE -P refs/ -P $(REFS)
	wget $(RDP16)/files/rdp_species_assignment_16.fa.gz -P $(REFS)
	wget $(RDP16)/files/rdp_train_set_16.fa.gz -P $(REFS)
	wget $(RDP14)/files/rdp_species_assignment_14.fa.gz -P $(REFS)
	wget $(RDP14)/files/rdp_train_set_14.fa.gz -P $(REFS)
	wget $(GREENGENES)/files/gg_13_8_train_set_97.fa.gz -P $(REFS)

test : ## Run DADA2 workflow with Mothur MiSeq test data
	# Set up data for analysis
	mkdir -p $(TEST_DL) $(TEST_DAT)
	wget http://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip -P $(TEST_DL)
	unzip $(TEST_DL)/MiSeqSOPData.zip -d $(TEST_DAT)

	# Remove and change data to fit expectations
	rm -rf $(TEST_DAT)/__MACOSX
	mv $(TEST_DAT)/MiSeq_SOP/* $(TEST_DAT)/ && rmdir $(TEST_DAT)/MiSeq_SOP

clean : ## Remove data from test_data/, download/, and refs/
	rm -rf $(TEST_DL) $(TEST_DAT) $(REFS)

.PHONY = help test clean install dl-ref-dbs

help : ## Help page for Makefile
	@grep -E '^[a-zA-Z_-]+ : .*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN { FS = ":.*?## " }; \
	    { printf "\33[36m%-30s\033[0m %s\n", $$1, $$2 }'

.DEFAULT_GOAL := help
