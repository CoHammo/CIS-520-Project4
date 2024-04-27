pthread:
	cd 3way-pthread && make

mpi:
	cd 3way-mpi && make

mpi-local:
	cd 3way-mpi && make local

openmp:
	cd 3way-openmp && make

all:
	make pthread
	make mpi
	make mpi-local
	make openmp
