#!/bin/bash
#SBATCH --job-name=20thread-mpi
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem-per-core=512M
#SBATCH --time=00:30:00
#SBATCH --constraint=moles
#SBATCH --output=results/20thread.out

../../hyperfine 'mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt' --warmup 2 --runs 20 --export-json results/20thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 20 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
