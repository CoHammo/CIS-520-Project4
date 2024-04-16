#!/bin/sh

# Script to easily run the program on Beocat. (Not Done)
# Run the program with: build/scorecard-pthread [file] [number of threads]

cd sbatch-scripts

sbatch 1thread.sh
sbatch 2thread.sh
sbatch 4thread.sh
sbatch 8thread.sh
sbatch 16thread.sh
sbatch 20thread.sh
