#!/bin/bash
#SBATCH --job-name=1thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=00:10:00
#SBATCH --constraint=moles
#SBATCH --output=results/1thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 1' --warmup 2 --runs 10 --export-json results/1thread-1.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 1' --warmup 2 --runs 10 --export-json results/1thread-2.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 1' --warmup 2 --runs 10 --export-json results/1thread-3.json
