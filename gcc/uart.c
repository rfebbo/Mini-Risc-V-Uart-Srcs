#include"uart.h" 

void uart_put(int c) {
	// int addr = 0; 
	// __asm__("lui %[b], 0xaaaaa\n\t"
	// 		"addi %[b],%[b],1024\n\t"
	// 		"sw %[a],0(%[b])"
	// 		: : [a] "r" (c), [b] "r" (addr));

	// __asm__("lui t0, 0xaaaaa\n\t"
	// 		"addi t0,t0,1024\n\t"
	// 		"sw %[a],0(t0)"
	// 		: : [a] "r" (c));
	volatile int * p = (int *)0xaaaaa400; 
	*p = c; 
}