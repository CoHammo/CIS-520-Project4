CC = gcc
CFLAGS = -g -Wall -Wextra -Wshadow #-Werror -D_XOPEN_SOURCE=500
# Look into performance measurements by compiling for gprof use

OUTDIR = build

TARGET = $(OUTDIR)/scorecard-pthread

SOURCES = scorecard-pthread.c

all: $(SOURCES)
	mkdir -p $(OUTDIR)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET) -lpthread

clean:
	rm -f *.o *.exe *.out
