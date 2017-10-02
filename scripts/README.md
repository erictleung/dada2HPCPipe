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

## Transferring Results to Local

You can run the following command on your local terminal to get plots or other
data.

```shell
# Explanation:
#   - scp - secure copy files
#   - username@exahead.ohsu:~/plots/plot-1.png - modify path after `:` for
#     files you want to transfer
#   - where/you/want/file.png - this is the path on your local instance
scp username@exahead1.ohsu.edu:~/plots/plot-1.png where/you/want/file.png
```
