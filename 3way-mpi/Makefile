#
# Open Systems Lab
# http://www.lam-mpi.org/tutorials/
# Indiana University
#
# MPI Tutorial
# Sample Makefile
#

# "mpicc" adds the directories for the include and lib files.  Hence,
# -I and -L for MPI stuff is not necessary
#

#CC        = mpicc

#
# Modify TOPDIR if you use your own include files and library files
#

#PROGRAM   = hello			# name of the binary
#SRCS      = MPI_C_SAMPLE.c		# source file
#OBJS      = $(SRCS:.c=.o)		# object file

#
# Targets
#

#default: all

#all: $(PROGRAM) 

#$(PROGRAM): $(OBJS)
#	$(CC) $(OBJS) -o $(PROGRAM) $(LDFLAGS)

#clean:
#	/bin/rm -f $(OBJS) $(PROGRAM)

CC = mpicc
CFLAGS = -Wall -Wextra -Wshadow #-Werror -D_XOPEN_SOURCE=500

OUTDIR = build

TARGET = $(OUTDIR)/scorecard-mpi

SOURCES = scorecard-mpi.c

all: $(SOURCES)
	mkdir -p $(OUTDIR)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET)

# For compiling on a local machine with mpich installed
LOCALCC = /usr/lib64/mpich/bin/mpicc
local: $(SOURCES)
	mkdir -p $(OUTDIR)
	$(LOCALCC) $(CFLAGS) $(SOURCES) -o $(TARGET)

run:
	cd sbatch-scripts && sbatch 1thread.sh
	cd sbatch-scripts && sbatch 2thread.sh
	cd sbatch-scripts && sbatch 4thread.sh
	cd sbatch-scripts && sbatch 8thread.sh
	cd sbatch-scripts && sbatch 16thread.sh
	cd sbatch-scripts && sbatch 20thread.sh
	cd sbatch-scripts && sbatch 30thread.sh
	cd sbatch-scripts && sbatch 40thread.sh

clean:
	rm -f *.o *.exe *.out
