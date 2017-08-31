# Makefile to Automate Analyses and Setup

test : ## Run DADA2 workflow with Mothur MiSeq test data
	# Set up data for analysis
	mkdir download test_data
	wget http://www.mothur.org/w/images/d/d6/MiSeqSOPData.zip -P download/
	unzip ./download/MiSeqSOPData.zip -d test_data/

	# Remove and change data to fit expectations
	rm -rf test_data/__MACOSX
	mv test_data/MiSeq_SOP/* test_data/ && rmdir test_data/MiSeq_SOP

clean : ## Remove data from data/ and download/
	rm -rf test_data download

.PHONY = help test clean

help : ## Help page for Makefile
	@grep -E '^[a-zA-Z_-]+ : .*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN { FS = ":.*?## " }; \
	    { printf "\33[36m%-30s\033[0m %s\n", $$1, $$2 }'

.DEFAULT_GOAL := help
