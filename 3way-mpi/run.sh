#!/bin/sh

# Run the program with: build/scorecard-mpi [file] [number of threads]

cd sbatch-scripts

sbatch 1thread.sh
sbatch 2thread.sh
sbatch 4thread.sh
sbatch 8thread.sh
sbatch 16thread.sh
sbatch 20thread.sh
sbatch 30thread.sh
sbatch 40thread.sh
