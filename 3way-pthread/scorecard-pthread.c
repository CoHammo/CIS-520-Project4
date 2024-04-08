#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>

#define NUM_LINES 1000000   // Reads up to 1 million lines
#define LINE_SIZE 2001      // Lines up to 2 thousand characters long

/**
 * Using pthreads isn't actually implemented yet,
 * but the base code for what needs to happen is done.
*/

int main(int argc, char *argv[])
{
    if (argc < 2) {
        printf("Must give a filename and number of threads to use\n");
        return -1;
    }
    else if (argc < 3) {
        printf("Must give number of threads to use\n"); // Number of threads not implemented yet
        return -1;
    }

    struct stat stats;
    if (stat(argv[1], &stats) == -1) {
        perror("stat");
        return -1;
    }
    printf("%ld bytes\n", stats.st_size);

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror(argv[1]);
        return -1;
    }
    
    int lineCount = 0;
    char *maxValues = calloc(NUM_LINES, sizeof(char));

    char *buffer = malloc(stats.st_size+1);
    fread(buffer, 1, stats.st_size, file);
    if (buffer[stats.st_size-1] != '\n') buffer[stats.st_size] = '\n';

    for (int i = 0; i <= stats.st_size; i++) {
        if (buffer[i] == '\n') {
            lineCount++;
        }
        if (buffer[i] > maxValues[lineCount]) maxValues[lineCount] = buffer[i];
    }


    printf("Lines: %d\n", lineCount);
}