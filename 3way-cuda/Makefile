CC = gcc
CFLAGS = -Wall -Wextra -Wshadow -Werror -D_XOPEN_SOURCE=500

OUTDIR = build

TARGET = $(OUTDIR)/scorecard-openmp

SOURCES = scorecard-openmp.c

all: $(SOURCES)
	mkdir -p $(OUTDIR)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET)

clean:
	rm -f *.o *.exe *.out