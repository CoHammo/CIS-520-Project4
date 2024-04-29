# Overview
This program takes a file and gets the maximum ASCII value from each line in the file using a given number of threads.
There are pthread, mpi, and openmp implentations of the program, and they can be run with the following commands once the program is compiled:
- pthread: scorecard-pthread \<file> \<threads>
- mpi: mpirun -n \<threads> scorecard-mpi \<file>
- openmp: scorecard-openmp \<file> \<threads>

# Compiling and Running
There is a Makefile in the top level directory of this git repo that has recipes for compiling and running the program on Beocat. Run `make all` from the top level directory to compile every version of the program. Then run `make run` to run every version of the program. This will use sbatch scripts to run and benchmark each version of the program multiple times with 1, 2, 4, 8, 16, 20, and 40 threads. You can also compile and run the programs in one step with `make build-and-run`, and there are recipes to compile and run one implementation of the program at a time in the Makefile in the top level directory, as well as in Makefiles in each implementation's directory.

# Benchmarks
The time the program takes to run is benchmarked with `hyperfine` when run on Beocat through the Makefile with sbatch scripts. The results of a benchmarking run are stored in `*thread.out` and `*thread.json` files in the `sbatch-scripts/results` directory of each implementation, with the star being the number of threads used for that benchmarking run.