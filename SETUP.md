Development Setup
=================

Here are instructions on how to get started on ExaCloud and setting up the
development environment needed to run the DADA2 workflow.

**Table of Contents**

- [Package Management](#package-management)
- [R Environment Setup](#r-environment-setup)
- [Slurm Workload Manager](#slurm-workload-manager)

Package Management
------------------

**Setup**

Follow the instructions listed in [this document][exacloud] to setup a modern
development environment on the cluster. This isn't necessary if your
development environment is on a cluster where you have root access or you're
implementing this workflow locally.

Briefly, following the instructions linked above will give you the following:

- Miniconda, Python package and virtual environment management
- Linuxbrew, non-root package management on Linux systems

[exacloud]: https://github.com/greenstick/bootstrapping-package-management-on-exacloud

**Interactive Session**

The current document hasn't been updated for the cluster new job scheduler,
slurm. To run an interactive-equivalent session, run the following:

```bash
srun --pty /usr/bin/bash -l
```

R Environment Setup
-------------------

There is a file `install-pkgs.R`, which contains code you can run to check the
correct version of R and install and/or check the necessary R packages to
install necessary to run the analysis.

Additionally, being on a cluster without root access, you'll want to specify
where to install your R packages. You can use the following to create a
`.Renviron` file to point to where you want to install R packages.

```r
# Change paths according to your personal setup
mkdir -p ~/R/library
echo 'R_LIBS_USER="~/R/library"' > $HOME/.Renviron
```

Source: https://csg.sph.umich.edu/docs/R/localpackages.html

Slurm Workload Manager
----------------------

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
