#include <mpi.h>
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

// Struct to store thread info
typedef struct {
    int index; // used to keep track of which thread has done work
    int start; // where the thread should start reading from the buffer
    int end; // where thre thread should stop reading from the buffer
    int bufferLength; // the length of the buffer to read from
    int linesCounted; // stores how many lines the thread counted
    int resultsSize; // initial allocation size of the results buffer
    char *buffer; // pointer to the buffer to read from
    char *results; // results buffer stores the highest ASCII value from each line the thread reads from
    bool allocFail; // whether allocation of the results buffer failed for the thread
} thread_info_t;

void *readLines(void *args) {
    thread_info_t *data = (thread_info_t *)args;
    data->results = calloc(data->resultsSize, sizeof(char)); // allocates results
    if (data->results == NULL) {
        data->allocFail = true;
        return NULL;
    }
    data->allocFail = false;

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
            data->results = realloc(data->results, data->resultsSize); // reallocated results buffer if needed
            if (data->results == NULL) {
                data->allocFail = true;
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


int main(int argc, char *argv[]) {
    // Error checking for correct number of arguments
    if (argc < 2) {
        printf("Must give a filename to use\n");
        return -1;
    }

    int numThreads, divide;
    int lineCount = 0;
    int maxValuesIndex = 0;
    char *results = NULL;
    thread_info_t thread_info;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numThreads);
    MPI_Comm_rank(MPI_COMM_WORLD, &(thread_info.index));

    // Get file stats
    struct stat stats;
    if (stat(argv[1], &stats) == -1) {
        perror("stat");
        return -1;
    }
    char *mainBuffer = malloc(stats.st_size+1);

    // Size of chunks that will be divided among the threads
    thread_info.bufferLength = stats.st_size;
    divide = thread_info.bufferLength / numThreads;

    if (thread_info.index == 0) {

        // Open the given file
        FILE *file = fopen(argv[1], "r");
        if (file == NULL) {
            perror(argv[1]);
            return -1;
        }
        printf("Opened file\n");

        // Read the file into a buffer
        if (fread(mainBuffer, 1, stats.st_size, file) < 1) {
            printf("Unable to read file: %s\n", argv[1]);
            return 1;
        }
        fclose(file);
        if (thread_info.buffer[stats.st_size-1] != '\n') thread_info.buffer[stats.st_size] = '\n';

        printf("Read file\n");
    }

    // printf("About to get data\n");
    // MPI_Barrier(MPI_COMM_WORLD);
    // MPI_Bcast(mainBuffer, stats.st_size, MPI_CHAR, 0, MPI_COMM_WORLD);
    // printf("Received Data");
    // printf("%d: %s\n", thread_info.index, mainBuffer);

    MPI_Finalize();

/*
    thread_info.resultsSize = THREAD_RESULTS_START_SIZE;
    thread_info.linesCounted = 0;
    thread_info.start = thread_info.index * divide;
    if (thread_info.index < numThreads - 1) thread_info.end = divide + thread_info.start;
    else thread_info.end = thread_info.bufferLength;

    readLines(&thread_info);

    MPI_Finalize();

    for (int i = 0; i < 1; i++) {
        if (thread_info.allocFail) {
            printf("Could not allocate thread %d results\n", i);
            return 1;
        }
        
        // Allocates results buffer based on lineCount
        results = realloc(results, (lineCount + thread_info.linesCounted) * LINE_STRING_SIZE);
        if (results == NULL) {
            printf("Could not allocate results\n");
            return 1;
        }

        // Gets the results from each thread and formats them into a string to eventually print
        for (int j = 0; j < thread_info.linesCounted; j++) {
            int index = (j + lineCount);
            maxValuesIndex += snprintf(&(results[maxValuesIndex]), LINE_STRING_SIZE, "%d: %d\n", index, thread_info.results[j]);
        }
        lineCount += thread_info.linesCounted;
    }

    printf("%s", results);

    free(thread_info.buffer);
    free(results);
    for (int i = 0; i < numThreads; i++) {
        free(thread_info.results);
    }*/
}
