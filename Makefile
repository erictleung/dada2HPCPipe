# Makefile to Automate Analyses and Setup

setup-dev : ## Check and setup appropriate R environment
	Rscript ./bin/install-pkgs.R

.PHONY = setup-dev help

help : ## Help page for Makefile
	@grep -E '^[a-zA-Z_-]+ : .*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN { FS = ":.*?## " }; \
	    { printf "\33[36m%-30s\033[0m %s\n", $$1, $$2 }'

.DEFAULT_GOAL := help
