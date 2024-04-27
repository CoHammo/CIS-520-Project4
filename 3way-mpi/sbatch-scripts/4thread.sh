#!/bin/bash
#SBATCH --job-name=4thread-mpi
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=4G
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/4thread.out

../../hyperfine 'mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt' --warmup 2 --runs 50 --export-json results/4thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
