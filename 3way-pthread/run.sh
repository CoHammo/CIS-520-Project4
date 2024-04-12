#!/bin/sh

# Script to easily run the program on Beocat. (Not Done)
# Run the program with: build/scorecard-pthread [file] [number of threads]

#build/scorecard-pthread ../wiki_dump.txt 4

sbatch --time=1 --mem-per-cpu=1G --cpus-per-task=1 --ntasks=1 --nodes=1 "build/scorecard-pthread ../wiki_dump.txt 4"