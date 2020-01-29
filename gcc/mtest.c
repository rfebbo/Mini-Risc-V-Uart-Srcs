#include"uart.h"
#include"stdlib.h" 

int main(void) {
	char *x = malloc(12 * sizeof(char)); 
	int i;
	for (i = 0; i < 12; i++) 
		x[i] = i + 48; 
	print(x);
}