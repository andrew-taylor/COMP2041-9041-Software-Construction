#include <stdlib.h>
#include <stdio.h>

int fib(int n) {
    if (n < 3) return 1;
    return fib(n-1) + fib(n-2);
}

int main(int argc, char *argv[]) {
    int i;
    for (i = 1; i < argc; i++) {
    	int n = atoi(argv[i]);
		printf("fib(%d) = %d\n", n, fib(n));
	}
    return 0;
}
