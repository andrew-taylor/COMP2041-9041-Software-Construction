#include <stdio.h>
#include <stdlib.h>

int check_password() {
	char buffer[8];
	printf("Enter password: ");
	gets(buffer);
	buffer[12] += 2; /* change function's return address on stack (gcc 4.3/Linux/i86)  */
	return strcmp(buffer, "secret") == 0;
}

int main(int argc, char *argv[]) {
	printf("function main is at address 0x%x\n", &main);
	if (check_password()) {
		printf("Authenticated\n");
	} else {
		printf("Password Incorrect\n");
	}
}
