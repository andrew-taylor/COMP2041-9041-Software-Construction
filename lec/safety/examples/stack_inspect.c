#include <stdio.h>
#include <stdlib.h>

void f() {
	int i;
	int x = 9;
	int a[10];
	
	for (i = 0; i < 16; i++)
		printf("%2d: Address %x contains 0x%x\n", i, &a[10+i], a[10+i]);
}

int main(void) {
	int a = 7;
	printf("function main is at address 0x%x\n", &main);
	printf("function f is at address 0x%x\n", &f);
	f();
	return 0;
}
