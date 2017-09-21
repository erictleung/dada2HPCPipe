# SLURM Scripts

## Overview

Here contains various SLURM scripts to run for each step of the pipeline.

Most of the scripts are preformatted and ready to go except the email
parameters to email you the results of the run.

To run most of the scripts, type in commands in this format:

```shell
sbatch test_pipeline.sh
```

## Analysis Workflow

When running the scripts found in the `test/` directory, it will generate a
particular directory structure to ease of looking at results and intermediate
steps.

The file structure should look similar to the following.

```
root/
|-- data/
|-- intermediate/
|-- metadata/
|-- README.md
|-- results/
|-- slurm_submit.sh
`-- src/

5 directories, 2 files
```
