#include"uart.h"
// #include"printf.h" 
#include"stdlib.h"
#include"page.h" 
#include"trap.h"

extern TrapFrame KERNEL_TRAP_FRAME;

void kinit(void) {
	print("kinit\n");
	// char buf[32];
	// int a = 5;
	// itoa(a, buf, 10);
	// print(buf);
	// mem_init();
	// print("kmem init\n");
	init_trap();
	print("trap init");
	asm volatile ("csrw mscratch, %0"
		: : "r" (&KERNEL_TRAP_FRAME));


	return;
}

int main(void) {
	// mem_init();
	print("Entered Main\n");
	asm volatile ("ecall");

	return 0;
	// void * ptr = alloc(2); 

	// print("Alloced 2 pages\n");
	// char buf[32];
	// itoa((int)ptr, buf, 16); 
	// print(buf);
	// while(1) {
	// 	char c = uart_read_blocking();
	// 	uart_write_blocking(c);
	// }
	// float f = 0.5f; 
	// float f2 = 0.75f;
	// float sum = f + f2; 
	// printf("%f + %f = %f\n", f, f2, sum);
}