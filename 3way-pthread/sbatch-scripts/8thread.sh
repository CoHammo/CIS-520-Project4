#!/bin/bash
#SBATCH --job-name=8thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=2G
#SBATCH --time=00:05:00
#SBATCH --output=8thread.out

time build/scorecard-pthread ~dan/625/wiki_dump.txt 8
