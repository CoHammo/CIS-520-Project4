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
    int allocFail; // whether allocation of the results buffer failed for the thread
} thread_info_t;

void *readLines(void *args) {
    thread_info_t *data = (thread_info_t *)args;
    data->results = calloc(data->resultsSize, sizeof(char)); // allocates results
    if (data->results == NULL) {
        data->allocFail = 1;
        return NULL;
    }
    data->allocFail = 0;

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

    int numThreads, divide;
    int lineCount = 0;
    int resultsIndex = 0;
    char *fullResults = NULL;
    thread_info_t thread_info;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numThreads);
    MPI_Comm_rank(MPI_COMM_WORLD, &(thread_info.index));

    // Error checking for correct number of arguments
    if (argc < 2) {
        if (thread_info.index == 0) {
            printf("Must give a filename to use\n");
        }
        return -1;
    }

    // Get file stats
    struct stat stats;
    if (stat(argv[1], &stats) == -1) {
        perror("stat");
        return -1;
    }
    thread_info.buffer = malloc(stats.st_size + 1);

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

        // Read the file into a buffer
        if (fread(thread_info.buffer, 1, stats.st_size, file) < 1) {
            printf("Unable to read file: %s\n", argv[1]);
            return 1;
        }
        fclose(file);
        if (thread_info.buffer[stats.st_size-1] != '\n') thread_info.buffer[stats.st_size] = '\n';
    }

    MPI_Barrier(MPI_COMM_WORLD);
    MPI_Bcast(thread_info.buffer, stats.st_size + 1, MPI_CHAR, 0, MPI_COMM_WORLD);

    // Fill the thread_info struct with info for the readLines method
    thread_info.resultsSize = THREAD_RESULTS_START_SIZE;
    thread_info.linesCounted = 0;
    thread_info.start = thread_info.index * divide;
    if (thread_info.index < numThreads - 1) thread_info.end = divide + thread_info.start;
    else thread_info.end = thread_info.bufferLength;

    readLines(&thread_info);

    // If this is not the first thread, receive the total line count so far from the previous thread
    if (numThreads > 1 && thread_info.index > 0) {
        MPI_Recv(&lineCount, 1, MPI_INT, thread_info.index - 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    // Check for allocation failure
    if (thread_info.allocFail) {
        printf("Could not allocate thread %d initial results", thread_info.index);
        return 1;
    }

    // Allocate buffer for results and check for failure
    fullResults = malloc((thread_info.linesCounted) * LINE_STRING_SIZE);
    if (fullResults == NULL) {
        printf("Could not allocate thread %d full results", thread_info.index);
        return 1;
    }

    // Create the full results string for this thread
    int index = lineCount;
    for (int i = 0; i < thread_info.linesCounted; i++) {
        resultsIndex += snprintf(&(fullResults[resultsIndex]), LINE_STRING_SIZE, "%d: %d\n", index, thread_info.results[i]);
        index++;
    }

    printf("%s", fullResults); // Print results for this thread

    // If this is not the last thread, send the line count so far to the next thread
    if (numThreads > 1 && thread_info.index < numThreads - 1) {
        int totalLineCount = thread_info.linesCounted + lineCount;
        MPI_Send(&totalLineCount, 1, MPI_INT, thread_info.index + 1, 0, MPI_COMM_WORLD);
    }

    free(fullResults);
    free(thread_info.buffer);
    free(thread_info.results);

    MPI_Finalize();
}
