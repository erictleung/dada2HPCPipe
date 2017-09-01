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
- [Development Setup](#development-setup)
    - [R Environment Setup](#r-environment-setup)
    - [Package Management](#package-management)
    - [Slurm Workload Manager](#slurm-workload-manager)
- [Troubleshooting](#troubleshooting)

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
clean                          Remove data from test_data/ and download/
help                           Help page for Makefile
install                        Install dada2HPCPipe package in R
test                           Run DADA2 workflow with Mothur MiSeq test data
```

## Development Setup

Here are instructions on how to get started on ExaCloud and setting up the
development environment needed to run the DADA2 workflow.

### Package Management

**Interactive Session**

To run an interactive session, run the following:

```bash
srun --pty /usr/bin/bash
```

This will allow you to test your code and workflow without worrying about
stressing out the head coordinating node.

**Setup**

Follow the instructions listed in [this document][exacloud] to setup a modern
development environment on the cluster. This isn't necessary if your
development environment is on a cluster where you have root access or you're
implementing this workflow locally.

Briefly, following the instructions linked above will give you the following:

- Miniconda, Python package and virtual environment management
- Linuxbrew, non-root package management on Linux systems

For this R workflow, you'll only really need to install Miniconda and R
essentials. The Anaconda environment has build [an `r-essential`
package][condar] with R and most used R packages for data science.

In sum,

```bash
# Download and install Miniconda
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh

# Say yes to adding Miniconda to .bash_profile

# Remove install file
rm Miniconda2-latest-Linux-x86_64.sh

# Exit the cluster and log back in to see changes

# Install R and relevant packages
conda install r-essentials

# For maintenance and update of all packages
conda update r-essentials

# For updating a single particular R package, replace XXXX
conda update r-XXXX
```

You'll need to sign out and sign back in of the cluster for the paths to be
reset so that R and other Conda installations will be used instead of the
system installations.

[exacloud]: https://github.com/greenstick/bootstrapping-package-management-on-exacloud
[condar]: https://conda.io/docs/r-with-conda.html

### Slurm Workload Manager

Slurm is the resource manager that I'll focus on for this workflow. Slurm
stands for "Simple Linux Utility for Resource Management."

Below are some useful commands to use within Slurm:

```bash
# Submit your script, first_script.sh
sbatch first_script.sh

# Look at jobs in the queue
squeue
```

You can use [this website][ceci] to help generate Slurm scripts. It is designed
for another cluster, but it should at least help with the initial drafting of a
submit script you'll want to use.

[ceci]: http://www.ceci-hpc.be/scriptgen.html

**Source**: http://www.cism.ucl.ac.be/Services/Formations/slurm/2016/slurm.pdf

## Troubleshooting

**Installing this package says it has trouble installing Bioconductor
packages**

There are two solutions for this. From within R, you can run the following

```R
setRepositories(ind=1:2)
```

which will tell R to also include Bioconductor packages in its package
search. See https://stackoverflow.com/a/34617938/6873133 for more information.

Additionally, you can install Bioconductor manually using the following within
R

```R
# Try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()
```

and then using `biocLite()` to install the missing packages. See
http://bioconductor.org/install/.
