#!/bin/bash
#SBATCH --job-name=2thread-mpi
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=2G
#SBATCH --nodes=1
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/2thread.out

../../hyperfine 'mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt' --warmup 2 --runs 50 --export-json results/2thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 2 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
