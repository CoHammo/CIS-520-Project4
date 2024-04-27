#!/bin/bash
#SBATCH --job-name=40thread-pthread
#SBATCH --ntasks=40
#SBATCH --mem-per-cpu=512M
#SBATCH --nodes=2
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/40thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 40' --warmup 2 --runs 50 --export-json results/30thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 40 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 40 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 40 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 40 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 40 | grep 'Bytes Used'
