# Commands to compile every version of the program
pthread:
	cd 3way-pthread && make

mpi:
	cd 3way-mpi && make

mpi-local:
	cd 3way-mpi && make local

openmp:
	cd 3way-openmp && make

all:
	-cd 3way-pthread && make
	@echo
	-cd 3way-mpi && make
	@echo
	-cd 3way-mpi && make local
	@echo
	-cd 3way-openmp && make


# Commands to run every version of the program
run-pthread:
	cd 3way-pthread && make run

run-mpi:
	cd 3way-mpi && make run

run-openmp:
	cd 3way-openmp && make run

run:
	-cd 3way-pthread && make run
	@echo
	-cd 3way-mpi && make run
	@echo
	-cd 3way-openmp && make run

# Command to build then run every version of the program
build-and-run:
	make all
	@echo
	make run