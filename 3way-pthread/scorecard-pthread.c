#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>
#include <pthread.h>
#include <stdbool.h>

#define THREAD_RESULTS_START_SIZE 5000
#define LINE_STRING_SIZE 13

// Struct to store thread communication info
typedef struct {
    int index;
    int start;
    int end;
    int bufferLength;
    int linesCounted;
    int resultsSize;
    char *buffer;
    char *results;
    bool reallocFail;
} thread_info_t;

void *readLines(void *args) {
    thread_info_t *data = (thread_info_t *)args;
    data->results = calloc(data->resultsSize, sizeof(char)); // allocates results
    data->reallocFail = false;

    // Seeks the correct start location
    if (data->index != 0) {
        while (data->buffer[data->start - 1] != '\n') {
            data->start++;
        }
    }

    // Seeks the correct end location
    while (data->buffer[data->end-1] != '\n' && data->end <= data->bufferLength) {
        data->end++;
    }

    char ch = 0; // used to keep track of highest ASCII value per line

    // Loop to look for the highest ASCII value per line
    for (int i = data->start; i < data->end; i++) {

        // Checks if the results buffer needs more memory allocated
        if (data->linesCounted == data->resultsSize) {
            data->resultsSize *= 2;
            data->results = realloc(data->results, data->resultsSize);
            if (data->results == NULL) {
                data->reallocFail = true;
                return NULL;
            }
        }
        
        // If newline, increment linesCounted and store the highest ASCII value,
        // otherwise check if the current char's value is greater than the highest value encountered so far.
        if (data->buffer[i] == '\n') {
            data->results[data->linesCounted] = ch;
            ch = 0;
            data->linesCounted++;
        }
        else if (data->buffer[i] > ch) {
            ch = data->buffer[i];
        }
    }
    return NULL;
}

int main(int argc, char *argv[])
{
    // Error checking for correct number of arguments given
    if (argc < 2) {
        printf("Must give a filename and number of threads to use\n");
        return -1;
    }
    else if (argc < 3) {
        printf("Must give number of threads to use\n");
        return -1;
    }

    int numThreads;
    int divide;
    int lineCount = 0;
    int maxValuesIndex = 0;
    char *results = NULL;
    char *buffer = NULL;

    // Get number of threads requested by user
    sscanf(argv[2], "%d", &numThreads);
    if (numThreads < 1) {
        printf("Cannot use less than 1 thread\n");
        return 1;
    }

    thread_info_t thread_info[numThreads];
    pthread_t threads[numThreads];

    // Get stats of the given file, needed to see how big the file is
    struct stat stats;
    if (stat(argv[1], &stats) == -1) {
        perror("stat");
        return -1;
    }
    printf("%ld bytes\n\n", stats.st_size);

    // Size of chunks that will be divided among the threads
    divide = stats.st_size / numThreads;

    // Open the given file
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror(argv[1]);
        return -1;
    }

    // Allocate buffer and read the entire file into it
    buffer = malloc(stats.st_size+1);
    fread(buffer, 1, stats.st_size, file);
    fclose(file);
    if (buffer[stats.st_size-1] != '\n') buffer[stats.st_size] = '\n';

    // Create threads with the correct info and run them
    for (int i = 0; i < numThreads; i++) {
        thread_info[i].bufferLength = stats.st_size;
        thread_info[i].linesCounted = 0;
        thread_info[i].index = i;
        thread_info[i].start = i * divide;
        if (i < numThreads - 1) thread_info[i].end = divide + thread_info[i].start;
        else thread_info[i].end = stats.st_size;
        thread_info[i].buffer = buffer;
        thread_info[i].resultsSize = THREAD_RESULTS_START_SIZE;
        if (pthread_create(&threads[i], NULL, readLines, &(thread_info[i]))) {
            perror("Thread");
            return 1;
        }
    }

    // "Joins" all extra threads to main thread, causing main thread to wait on them.
    // After each thread finishes, max ASCII values are updated.
    for (int i = 0; i < numThreads; i++) {
        if (pthread_join(threads[i], NULL)) {
            perror("Thread");
            return 1;
        }
        
        // Allocates results buffer based on lineCount
        results = realloc(results, (lineCount + thread_info[i].linesCounted) * LINE_STRING_SIZE);
        if (results == NULL) {
            printf("Could not allocate results");
            return 1;
        }

        // Gets the results from each thread and formats them into a string to eventually print
        for (int j = 0; j < thread_info[i].linesCounted; j++) {
            int index = (j + lineCount);
            maxValuesIndex += snprintf(&(results[maxValuesIndex]), LINE_STRING_SIZE, "%d: %d\n", index, thread_info[i].results[j]);
        }
        lineCount += thread_info[i].linesCounted;
    }

    printf("%s", results); // Print results

    // Used for debugging
    /*printf("Line Counts String Size: %d\n", lineCount*LINE_STRING_SIZE);
    printf("Bytes Written to Line Counts String: %d\n", maxValuesIndex);
    printf("Lines Counted: %d\n", lineCount);
    for (int i = 0; i < numThreads; i++) {
        if (thread_info[i].reallocFail) printf("Thread %d: Line Overflow Error\n", i);
        printf("(%d) Line Results Size: %d\n", i, thread_info[i].resultsSize);
        printf("(%d) Lines Counted: %d\n", i, thread_info[i].linesCounted);
    }*/

    free(buffer);
    free(results);
    for (int i = 0; i < numThreads; i++) {
        free(thread_info[i].results);
    }
}

