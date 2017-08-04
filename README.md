# dada2-hpc-workflow

16S rRNA microbiome data analysis workflow using DADA2 and R on a high
performance cluster.

**Table of Conents**

- [Description](#description)
- [Overview of Makefile](#overview-of-makefile)

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
