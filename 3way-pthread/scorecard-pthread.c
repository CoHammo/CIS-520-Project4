#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <pthread.h>

#define NUM_LINES 1000001   // Reads up to 1 million lines
#define LINE_SIZE 2001      // Lines up to 2 thousand characters long

/**
 * Using pthreads isn't actually implemented yet,
 * but the base code for what needs to happen is done.
*/

typedef struct {
    int index;
    int numThreads;
    int divide;
    int lineCount;
    char **buffer;
} thread_info_t;

void *readLines(void *args) {
    thread_info_t data = *((thread_info_t *)args);
    int start = data.index * data.divide;
    int end;
    if (data.index + 1 == data.numThreads) end = data.lineCount;
    else end = data.divide + start;
    for (int i = start; i < end; i++) {
        printf("(%d) %d: %s\n", data.index + 1, i + 1, "line");
    }
    //printf("%d: %s", data.index, data.buffer[data.index]);
    return NULL;
}

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

    printf("working 0\n");
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

    int numThreads;
    sscanf(argv[2], "%d", &numThreads);
    
    int lineCount = 0;
    char *maxValues = calloc(NUM_LINES, sizeof(char));

    //char *buffer = malloc(stats.st_size+1);
    //fread(buffer, 1, stats.st_size, file);
    //if (buffer[stats.st_size-1] != '\n') buffer[stats.st_size] = '\n';

    printf("woring 1\n");

    char **newBuffer = malloc(NUM_LINES);
    newBuffer[0] = malloc(LINE_SIZE);
    while (fgets(newBuffer[lineCount], LINE_SIZE, file) != NULL && lineCount < NUM_LINES - 1) {
        lineCount++;
        newBuffer[lineCount] = malloc(LINE_SIZE);
    }

    printf("working 2\n");

    int divide = lineCount / numThreads;

    thread_info_t info[numThreads];

    // Create threads and run them, right now each thread just prints which thread it is.
    pthread_t threads[numThreads];
    for (int i = 0; i < numThreads; i++) {
        info[i].index = i;
        info[i].divide = divide;
        info[i].numThreads = numThreads;
        info[i].lineCount = lineCount;
        info[i].buffer = newBuffer;
        if (pthread_create(&threads[i], NULL, readLines, &(info[i]))) {
            perror("Thread");
            return 1;
        }
    }

    // "Joins" threads to main thread, causing the main thread to wait on other threads
    for (int i = 0; i < numThreads; i++) {
        if (pthread_join(threads[i], NULL)) {
            perror("Thread");
            return 1;
        }
    }

    /*
    // Counts number of lines in the file
    for (int i = 0; i <= stats.st_size; i++) {
        if (buffer[i] == '\n') {
            lineCount++;
        }
        if (buffer[i] > maxValues[lineCount]) maxValues[lineCount] = buffer[i];
    }*/
    
    printf("Lines: %d\n", lineCount);
}

