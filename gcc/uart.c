#include"uart.h" 

void uart_put(char c) {
	volatile char * p = (char *)0xaaaaa400; 
	*p = c; 
}

char uart_get() {
	volatile char *p = (char *)0xaaaaa400;
	return *p; 
}
char uart_poll() {
	volatile char * p = (char *)0xaaaaa404; 
	return *p; 
}

void uart_write_blocking(char c) {
	char s; 
	do {
		s = uart_poll() & 2;
	} while(s != 0);
	uart_put(c);
}

char uart_read_blocking() {
	char s;
	do {
		s = uart_poll() & 1; 
	} while(s == 0);

	return uart_get();

}

void print(char c[], int strlen) {
	for (int i = 0; i < strlen; i++) {
		uart_write_blocking(c[i]); 
	}
}