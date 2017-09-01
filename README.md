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
test                          Run DADA2 workflow with Mothur MiSeq test data
```

## Development Setup

Here are instructions on how to get started on ExaCloud and setting up the
development environment needed to run the DADA2 workflow.

### R Environment Setup

There is a file `install-pkgs.R`, which contains code you can run to check the
correct version of R and install and/or check the necessary R packages to
install necessary to run the analysis.

Additionally, being on a cluster without root access, you'll want to specify
where to install your R packages, as you can't write to more upstream
directories. You can use the following to create a `.Renviron` file for R to
point to where you want to install R packages.

```bash
# Change paths according to your personal setup
mkdir -p ~/R/library
echo 'R_LIBS_USER="~/R/library"' > $HOME/.Renviron
```

Source: https://csg.sph.umich.edu/docs/R/localpackages.html

### Package Management

**Interactive Session**

To run an interactive session, run the following:

```bash
srun --pty /usr/bin/bash -l
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
# Open an interactive session
srun --pty bash -l

# Download and install Miniconda
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh

# Say yes to adding Miniconda to .bash_profile

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

Source: http://www.cism.ucl.ac.be/Services/Formations/slurm/2016/slurm.pdf
