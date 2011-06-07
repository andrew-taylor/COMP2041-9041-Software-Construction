// Written by andrewt@cse.unsw.edu.au
// as a COMP2041 lecture example

#include <stdio.h>
#include <stdlib.h>

// copy input to output using stdio functions
// stdio buffers reads & writes for you - efficient and portable

void
copy_file_to_file(FILE *in, FILE *out) {
    while (1) {
        int ch = fgetc(in);
        if (ch == EOF)
             break;
        if (fputc(ch, out) == EOF) {
            fprintf(stderr, "cp:");
            perror("");
            exit(1);
        }
    }
}

int
main(int argc, char *argv[]) {
    FILE *in, *out;
    
    if (argc != 3) {
        fprintf(stderr, "cp <src-file> <destination-file>\n");
        return 1;
    }
    
    in = fopen(argv[1], "r");
    if (in == NULL) {
        fprintf(stderr, "cp: %s: ", argv[1]);
        perror("");
        return 1;
    }
    
    out = fopen(argv[2], "w");
    if (out == NULL) {
        fprintf(stderr, "cp: %s: ", argv[2]);
        perror("");
        return 1;
    }
    copy_file_to_file(in, out);
    return 0;
}
