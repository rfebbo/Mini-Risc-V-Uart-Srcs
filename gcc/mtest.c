#include"uart.h"
#include"malloc.h" 

int main(void) {
	uart_init();
	char *x = malloc(12 * sizeof(char)); 
	int i;
	for (i = 0; i < 12; i++) 
		x[i] = i + 48; 
	uart_print(x);
}