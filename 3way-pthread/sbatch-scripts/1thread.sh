#!/bin/bash
#SBATCH --job-name=1thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --output=1thread.out

time build/scorecard-pthread ~dan/625/wiki_dump.txt 1
