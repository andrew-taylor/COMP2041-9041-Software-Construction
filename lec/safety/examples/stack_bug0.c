#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int i;
	int a[10];
	int b[10];
	printf("i is at address 0x%x\n",(int)&i, (int)&a[0], (int)&a[9]);
	printf("a[0] is at address 0x%x\n",(int)&a[0]);
	printf("a[9] is at address 0x%x\n", (int)&a[9]);
	printf("b[0] is at address 0x%x\n",(int)&b[0]);
	printf("b[9] is at address 0x%x\n", (int)&b[9]);
	for (i = 0; i < 10; i++)
		a[i] = 77;
	/*
	 * loop writes to b[10] which doesn't exist -
	 * but with gcc 4.3 on x86/Linux b[13] happens to correspond to a[0]
	 */
	for (i = 0; i <= 10; i++)
		b[i] = 42;
	for (i = 0; i < 10; i++)
		printf("%d ", a[i]);
	printf("\n");
	return 0;
}
