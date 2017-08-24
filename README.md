# dada2HPCPipe

16S rRNA microbiome data analysis workflow using DADA2 and R on a high
performance cluster.

This repository contains essentially wrapper functions around DADA2 functions
in order to streamline the workflow for cluster computing.

This package is meant to serve two purposes: be an R package and give structure
to an analysis. The project aims to follow an R package structure, which can be
downloaded and installed as such. Additionally, the users is expected to
download this repository and run `make` and slurm commands to run scripts.

**Table of Conents**

- [Installation](#installation)
- [Description](#description)
- [Overview of Makefile](#overview-of-makefile)

## Installation

```R
install.packages("devtools")
devtools::install_github("erictleung/dada2HPCPipe")
```

## Description

This DADA2 workflow stems from the [DADA2 tutorial][dada2tut] and [big data
tutorial][dada2big]. You can find more information about the DADA2 package from
its [publication][nature] or from [GitHub][github].

[dada2tut]: http://benjjneb.github.io/dada2/tutorial.html
[dada2big]: http://benjjneb.github.io/dada2/bigdata.html
[nature]: http://dx.doi.org/10.1038/nmeth.3869
[github]: https://github.com/benjjneb/dada2

## Overview of Makefile

```
clean                         Remove data from data/ and download/
help                          Help page for Makefile
setup-dev                     Check and setup appropriate R environment
test                          Run DADA2 workflow with Mothur MiSeq test data
```
