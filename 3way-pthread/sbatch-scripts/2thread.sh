#!/bin/bash
#SBATCH --job-name=2thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=3G
#SBATCH --time=00:010:00
#SBATCH --constraint=moles
#SBATCH --output=results/2thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 2' --warmup 2 --runs 10 --export-json results/2thread-1.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 2' --warmup 2 --runs 10 --export-json results/2thread-2.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 2' --warmup 2 --runs 10 --export-json results/2thread-3.json
