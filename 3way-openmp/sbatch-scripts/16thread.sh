#!/bin/bash
#SBATCH --job-name=16thread-openmp
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem-per-core=512M
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/16thread.out

../../hyperfine '../build/scorecard-openmp ~dan/625/wiki_dump.txt 16' --warmup 2 --runs 50 --export-json results/16thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 16 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 16 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 16 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 16 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-openmp ~dan/625/wiki_dump.txt 16 | grep 'Bytes Used'
