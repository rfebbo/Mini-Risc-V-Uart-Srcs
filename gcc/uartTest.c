#include"uart.h" 
// #include"print.h" 

int main(void) {
	int c = 65; 
	// print(c);
	// uart_put(c);
	for (c = 65; c < 70; c++)uart_write_blocking(c);
		// uart_put(c);
	// while(1);
	// int c;
	// while(1) {
	// 	c = uart_read_blocking(); 
	// 	uart_put(c);
		// for (int i = 0; i < 100000000; i++);

		// uart_put(c);
		// if (c > 122) c = 65;
		// else c++; 
	// }
}