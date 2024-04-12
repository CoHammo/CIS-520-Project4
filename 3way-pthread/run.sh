#!/bin/sh

# Script to easily run the program on Beocat. (Not Done)
# Run the program with: build/scorecard-pthread [file] [number of threads]

sbatch -J 1thread --time=1 --mem-per-cpu=2G --cpus-per-task=1 --ntasks=1 --nodes=1 sbatch-scripts/1thread.sh
sbatch -J 2thread --time=1 --mem-per-cpu=1G --cpus-per-task=2 --ntasks=1 --nodes=1 sbatch-scripts/2thread.sh
sbatch -J 4thread --time=1 --mem-per-cpu=512M --cpus-per-task=4 --ntasks=1 --nodes=1 sbatch-scripts/4thread.sh