#!/bin/bash
#SBATCH --job-name=4thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --output=4thread.out

time build/scorecard-pthread ~dan/625/wiki_dump.txt 4
