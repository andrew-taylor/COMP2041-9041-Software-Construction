// Written by andrewt@cse.unsw.edu.au
// as a COMP2041 lecture example

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

// copy input to output using read/write system calls
// for every 4096 bytes - efficient but Unix/Linux specific

void
copy_file_to_file(int in_fd, int out_fd) {
    while (1) {
        char c[8192];
        int bytes_read = read(in_fd, c, sizeof c);
        if (bytes_read < 0) {
            perror("cp: ");
            exit(1);
        }
        if (bytes_read <= 0)
            return;
        int bytes_written = write(out_fd, c, bytes_read);
        if (bytes_written <= 0) {
            perror("cp: ");
            exit(1);
        }
    }
}

int
main(int argc, char *argv[]) {
     if (argc != 3) {
        fprintf(stderr, "cp <src-file> <destination-file>\n");
        return 1;
    }
    
    int in_fd = open(argv[1], O_RDONLY);
    if (in_fd < 0) {
        fprintf(stderr, "cp: %s: ", argv[1]);
        perror("");
        return 1;
    }
    
    int out_fd = open(argv[2], O_WRONLY|O_CREAT|O_TRUNC, S_IRWXU);
    if (out_fd <= 0) {
        fprintf(stderr, "cp: %s: ", argv[2]);
        perror("");
        return 1;
    }
    copy_file_to_file(in_fd, out_fd);
    return 0;
}
