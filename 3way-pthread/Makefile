CC = gcc
CFLAGS = -g -Wall -Wextra -Wshadow #-Werror -D_XOPEN_SOURCE=500

OUTDIR = build

TARGET = $(OUTDIR)/scorecard-pthread

SOURCES = scorecard-pthread.c

all: $(SOURCES)
	mkdir -p $(OUTDIR)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET) -lpthread

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
