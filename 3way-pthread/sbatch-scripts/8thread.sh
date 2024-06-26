#!/bin/bash
#SBATCH --job-name=8thread-pthread
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem-per-core=512M
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/8thread.out

../../hyperfine '../build/scorecard-pthread ~dan/625/wiki_dump.txt 8' --warmup 2 --runs 50 --export-json results/8thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 8 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 8 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 8 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 8 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-pthread ~dan/625/wiki_dump.txt 8 | grep 'Bytes Used'
