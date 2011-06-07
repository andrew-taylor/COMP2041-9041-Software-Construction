#include <stdio.h>
#include <stdlib.h>

void f() {
	int a[10];
	a[11] += 4;  /* change function's return address on stack (gcc 4.3/Linux/i86)  */
}

int main(void) {
	int answer = 41;
	f();
	answer++;
	printf("answer=%d\n", answer);
	return 0;
}
