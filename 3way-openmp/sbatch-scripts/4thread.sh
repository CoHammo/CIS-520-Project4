#!/bin/bash
#SBATCH --job-name=4thread-openmp
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=4G
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/4thread.out

../../hyperfine '../build/scorecard-openmp ~dan/625/wiki_dump.txt 4' --warmup 2 --runs 50 --export-json results/4thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 4 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 4 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 4 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 4 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 4 | grep 'Bytes Used'
