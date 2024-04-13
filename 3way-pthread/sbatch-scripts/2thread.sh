#!/bin/bash
#SBATCH --job-name=2thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --output=2thread.out

time build/scorecard-pthread ~dan/625/wiki_dump.txt 2
