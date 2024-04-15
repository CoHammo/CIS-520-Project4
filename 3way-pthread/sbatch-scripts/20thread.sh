#!/bin/bash
#SBATCH --job-name=20thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=3G
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=moles
#SBATCH --output=results/20thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 20' --warmup 2 --runs 40 --export-json results/20thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 20 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 20 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 20 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 20 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 20 | grep 'Bytes Used'