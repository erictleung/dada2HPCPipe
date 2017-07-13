Development Setup
=================

Here are instructions on how to get started on ExaCloud and setting up the
development environment needed to run the DADA2 workflow.

**Table of Contents**

- [Package Management](#package-management)
- [R Environment Setup](#r-environment-setup)

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
