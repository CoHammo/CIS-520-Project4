#!/bin/bash
#SBATCH --job-name=30thread-mpi
#SBATCH --nodes=2
#SBATCH --ntasks=30
#SBATCH --mem-per-core=1G
#SBATCH --time=00:30:00
#SBATCH --constraint=moles
#SBATCH --output=results/30thread.out

../../hyperfine 'mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt 30' --warmup 2 --runs 20 --export-json results/30thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 30 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
