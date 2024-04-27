#!/bin/bash
#SBATCH --job-name=40thread-mpi
#SBATCH --nodes=2
#SBATCH --ntasks=40
#SBATCH --mem=4G
#SBATCH --time=00:15:00
#SBATCH --constraint=moles
#SBATCH --output=results/40thread.out

../../hyperfine 'mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt 40' --warmup 2 --runs 50 --export-json results/40thread.json

/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 2: %M Bytes Used' mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 3: %M Bytes Used' mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 4: %M Bytes Used' mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
/usr/bin/time -f 'Run 5: %M Bytes Used' mpirun -n 40 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
