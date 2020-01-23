#include"uart.h" 
// #include"print.h" 

int main(void) {
	int c = 65; 
	// print(c);
	// uart_put(c);
	// while(1);
	while(1) {
		for (int i = 0; i < 100000000; i++);
			
		uart_put(c);
	}
}