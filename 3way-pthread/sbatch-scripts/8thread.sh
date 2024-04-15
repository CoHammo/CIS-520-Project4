#!/bin/bash
#SBATCH --job-name=8thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=3G
#SBATCH --time=00:10:00
#SBATCH --constraint=moles
#SBATCH --output=results/8thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 8' --warmup 2 --runs 10 --export-json results/8thread-1.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 8' --warmup 2 --runs 10 --export-json results/8thread-2.json
../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 8' --warmup 2 --runs 10 --export-json results/8thread-3.json
