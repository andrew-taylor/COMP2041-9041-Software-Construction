#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int i;
	int a[10];
	printf("i is at address 0x%x\n",(int)&i, (int)&a[0], (int)&a[9]);
	printf("a[0] is at address 0x%x\n",(int)&a[0]);
	printf("a[9] is at address 0x%x\n", (int)&a[9]);
	printf("a[10] is equivalent to address 0x%x\n", (int)&a[10]);
	/*
	 * loop writes to a[11] which doesn't exist -
	 * but (with gcc-4.3 on x86/Linux) happens to correspond to i
	 * Loop hence doesn't terminate
	 */
	for (i = 0; i <= 10; i++)
		a[i] = 0;
	return 0;
}
