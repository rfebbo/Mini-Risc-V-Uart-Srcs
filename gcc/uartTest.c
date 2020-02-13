#include"uart.h" 
// #include"print.h" 

int main(void) {
	// int c = 65; 
	// for (c = 65; c < 70; c++) {
	// 	print(c);
	// 	uart_write_blocking(c);
	// }
	// 	// uart_put(c);
	// while(1);
	// int c;
	// while(1) {
	// 	c = uart_read_blocking(); 
	// 	// uart_put(c);
	// 	print(c);
	// 	uart_write_blocking(c);

	// }
	char h[] = "Hello, world!\r\n"; 
	// // int strlen = 13; 
	print(h);
	char in[32];
	for (int i = 0; i < 32; i++)
		in[i] = 0;
	readline(in, 32); 
	print(in);
	char c; 
	while(1) {
		c = uart_read_blocking();
		uart_write_blocking(c);
	}
	return 0;
}