#!/bin/bash
#SBATCH --job-name=1thread-mpi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=16G
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/1thread.out

../../hyperfine 'mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt' --warmup 2 --runs 50 --export-json results/1thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 1 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
