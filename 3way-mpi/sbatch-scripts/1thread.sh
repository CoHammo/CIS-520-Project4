#!/bin/bash
#SBATCH --job-name=1thread
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --nodes=1
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/1thread.out

../../hyperfine '../build/scorecard-mpi ~dan/625/wiki_dump.txt 1' --warmup 2 --runs 50 --export-json results/1thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' ../build/scorecard-mpi ~dan/625/wiki_dump.txt 1 | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' ../build/scorecard-mpi ~dan/625/wiki_dump.txt 1 | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' ../build/scorecard-mpi ~dan/625/wiki_dump.txt 1 | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' ../build/scorecard-mpi ~dan/625/wiki_dump.txt 1 | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' ../build/scorecard-mpi ~dan/625/wiki_dump.txt 1 | grep 'Bytes Used'
