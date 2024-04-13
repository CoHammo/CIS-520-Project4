#!/bin/bash
#SBATCH --job-name=16thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=2G
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --constraint=moles
#SBATCH --output=16thread.out

time build/scorecard-pthread ~dan/625/wiki_dump.txt 16
