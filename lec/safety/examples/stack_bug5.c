/* run a.out <input_overflow */

#include <stdio.h>
#include <stdlib.h>

int check_password() {
	char buffer[8];
	gets(buffer);      /* buffer overflow can change values on the stack */
	return strcmp(buffer, "secret") == 0;
}

int main(int argc, char *argv[]) {
	if (check_password()) {
		printf("Authenticated\n");
	} else {
		printf("Password Incorrect\n");
	}
}
