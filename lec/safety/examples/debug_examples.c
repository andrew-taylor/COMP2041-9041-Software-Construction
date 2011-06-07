#include <stdio.h>
#include <stdlib.h>

// detected by gcc -O -Wall
// detected by valgrind
void test0(void) {
	int i;
	// accessing uninitialized local variable
	printf("%d\n", i);
}

// detected by gcc -fmudflap -lmudflap
// detected by valgrind
void test1(void) {
	int *a = malloc(10*sizeof (int));
	// accessing variable outside malloc'ed region
	a[10] = 42;
}

// detected by gcc -fmudflap -lmudflap
// detected by valgrind
void test2(void) {
	int *a = malloc(10);
	// accessing variable outside malloc'ed region
	a[5] = 42;
}

// detected by gcc -fmudflap -lmudflap
// detected by valgrind
void test3(void) {
	int *a = NULL;
	// dereferencing NULL pointer
	a[5] = 42;
}

// detected by valgrind
void test4(void) {
	int i;
	int a[10];
	for (i = 0; i < 10; i++)
		if (i != 4)
			a[i] = i;
	// accessing uninitialized array element (a[4])
	for (i = 0; i < 10; i++)
		printf("%d\n", a[i]);
}

// detected by valgrind
void test5(void) {
	int i;
	int *a = malloc(10*sizeof (int));
	for (i = 0; i < 10; i++)
		if (i != 4)
			a[i] = i;
	// accessing uninitialized part of malloc'ed region
	for (i = 0; i < 10; i++)
		printf("%d\n", a[i]);
}

// detected by gcc -fmudflap -lmudflap
// detected by valgrind
void test6(void) {
	int *p = malloc(10*sizeof *p);
	int *q = p;
	free(p);
	// accessing free'd area
	q[4] = 42;
}

// detected by valgrind '--leak-check=yes'
void test7(void) {
	int *p = malloc(10*sizeof *p);
	// malloc'ed space isn't freed
}

// detected by gcc -fmudflap -lmudflap
// detected by valgrind 
void test8(void) {
	int *p = malloc(10*sizeof *p);
	int *q = p;
	free(p);
	// multiple free
	free(q);
}

int main(int argc, char*argv[]) {
	switch (atoi(argv[1])) {
	case 0: test0(); break;
	case 1: test1(); break;
	case 2: test2(); break;
	case 3: test3(); break;
	case 4: test4(); break;
	case 5: test5(); break;
	case 6: test6(); break;
	case 7: test7(); break;
	case 8: test8(); break;
	}
	return 0;
}
