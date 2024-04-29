README: Parallel Processing of Wikipedia Articles on Beocat
Overview
This project demonstrates the use of MPI, OpenMP, and Pthread for processing a large dataset consisting of Wikipedia articles. Detailed instructions are provided below for compiling and running the project on Beocat.

Prerequisites
Before compiling and running the code, ensure you have loaded the necessary modules. These include tools for compiling (GCC, CMake) and managing parallel processes (OpenMPI, CUDA).

Compiling the Code
Load Required Modules:
bash
Copy code
module load CMake/3.23.1-GCCcore-11.3.0 foss/2022a OpenMPI/4.1.4-GCC-11.3.0 CUDA/11.7.0
Navigate to the Desired Directory:
Choose the directory based on the parallelization technology you are testing (MPI, OpenMP, or Pthread).
bash
Copy code
cd path/to/mpi_or_openmp_or_pthread_directory
Compile the Code:
Use the make command to compile the code. This command utilizes the Makefile provided in each directory, which contains specific build instructions.
bash
Copy code
make
Running the Code
Test Execution:
After compilation, you can run the tests directly from the command line or through scheduling scripts provided in the sbatch-scripts directory. Example commands are included in the Makefile, which use /usr/bin/time to measure memory usage and execution time.
bash
Copy code
/usr/bin/time -f 'Run 1: %M Bytes Used' mpirun -n 4 ../build/scorecard-mpi ~dan/625/wiki_dump.txt | grep 'Bytes Used'
Schedule Jobs on Beocat:
For scheduling and running the jobs via SLURM, navigate to the sbatch-scripts directory and submit the job using sbatch.
bash
Copy code
cd sbatch-scripts
sbatch job_script_name.sh
Checking Results
Results from the scheduled jobs can be found in the results directory within the sbatch-scripts folder. Each output file is named according to the number of threads and the specific technology used.

Additional Notes
Ensure that the path to the Wikipedia dataset (~dan/625/wiki_dump.txt) is correct and accessible.
Modify the SLURM scripts as needed to match the specific requirements of your Beocat environment.
For more detailed information on the project setup, refer to the project documentation and source code comments.

