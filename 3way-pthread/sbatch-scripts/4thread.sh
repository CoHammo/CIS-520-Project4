#!/bin/bash
#SBATCH --job-name=4thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=3G
#SBATCH --time=00:10:00
#SBATCH --constraint=moles
#SBATCH --output=results/4thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 4' --warmup 2 --runs 10 --export-json results/4thread-1.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 4' --warmup 2 --runs 10 --export-json results/4thread-2.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 4' --warmup 2 --runs 10 --export-json results/4thread-3.json
