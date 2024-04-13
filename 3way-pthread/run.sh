#!/bin/sh

# Script to easily run the program on Beocat. (Not Done)
# Run the program with: build/scorecard-pthread [file] [number of threads]

sbatch sbatch-scripts/1thread.sh
sbatch sbatch-scripts/2thread.sh
sbatch sbatch-scripts/4thread.sh
sbatch sbatch-scripts/8thread.sh
sbatch sbatch-scripts/16thread.sh
