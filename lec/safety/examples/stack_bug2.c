#include <stdio.h>
#include <stdlib.h>

void f(int x) {
	int a[10];
	a[20] = -1; /* change variable answer in main (gcc 4.3/linux/i86)  */
}

int main(void) {
	int answer = 42;
	f(5);
	printf("answer=%d\n", answer);
	return 0;
}
