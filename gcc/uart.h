#ifndef UART
#define UART 

void uart_put(int c); 
int uart_get(); 
int uart_poll(); 
void uart_write_blocking(int c);
int uart_read_blocking();

#endif