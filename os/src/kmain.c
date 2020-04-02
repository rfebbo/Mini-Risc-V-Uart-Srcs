#include"uart.h"
#include"printf.h" 
#include"page.h" 

void kinit(void) {
	printf("kinit\n");
	int a = 5;
	printf("Printf test: %d\n", a);
	// mem_init();
	// printf("kmem init\n");
	return;
}

int main(void) {
	// mem_init();
	printf("Entered Main\n");
	// while(1) {
	// 	char c = uart_read_blocking();
	// 	uart_write_blocking(c);
	// }
	// float f = 0.5f; 
	// float f2 = 0.75f;
	// float sum = f + f2; 
	// printf("%f + %f = %f\n", f, f2, sum);
}