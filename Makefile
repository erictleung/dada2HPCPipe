# Makefile to Automate Analyses and Setup

setup-dev : ## Check and setup appropriate R environment
	Rscript ./R/install_pkgs.R

test : ## Run DADA2 workflow with Mothur MiSeq test data
	# Set up data for analysis
	mkdir download data
	wget http://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip -P download/
	unzip ./download/MiSeqSOPData.zip -d data/

	# Remove and change data to fit expectations
	rm -rf data/__MACOSX
	mv data/MiSeq_SOP/* data/ && rmdir data/MiSeq_SOP

clean : ## Remove data from data/ and download/
	rm -rf data download

.PHONY = setup-dev help test clean

help : ## Help page for Makefile
	@grep -E '^[a-zA-Z_-]+ : .*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN { FS = ":.*?## " }; \
	    { printf "\33[36m%-30s\033[0m %s\n", $$1, $$2 }'

.DEFAULT_GOAL := help
