#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

void test0(int x, int y, int a[x][y]) {
	int i, j;
	fprintf(stderr, "writing to array i-j order\n");
	for (i = 0; i < x; i++)
		for (j = 0; j < y; j++)
			a[i][j] = i+j;
}

void test1(int x, int y, int a[x][y]) {
	fprintf(stderr, "writing to array j-i order\n");
	int i, j;
	for (j = 0; j < y; j++)
		for (i = 0; i < x; i++)
			a[i][j] = i+j;
}


int main(int argc, char*argv[]) {
	int x = atoi(argv[2]); 
	int y = atoi(argv[3]);
	fprintf(stderr, "allocating a %dx%d array = %lld bytes\n", x, y, ((long long)x)*y*sizeof (int));
	void *m = malloc(x*y*sizeof (int));
	assert(m);
	switch (atoi(argv[1])) {
	case 0: test0(x, y, m); break;
	case 1: test1(x, y, m); break;
	}
	return 0;
}
