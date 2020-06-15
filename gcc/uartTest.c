#include "uart.h"
#include "utils.h"
//#include "print.h"

int main(void)
{/*
	int i;
	char h[] = "Hello.\r\n";
	for (i = 0; i < 8; i++)
	{
		uart_write_blocking(h[i]);
	}*/

	int num = 298;
	int size = 0;
	int i;
	char c[30];

	size = count_digits(num);
	itoa(num, c);
	
	uart_write_blocking(65);

	for (i = 0; i < size; i++)
	{
		uart_write_blocking(c[i]);
	}
	
	uart_write_blocking(c[0]);
	uart_write_blocking(c[1]);
	uart_write_blocking(c[2]);

	uart_write_blocking(69);
/*
	int c = 65;
	for (c = 65; c < 70; c++)
	{
		print(c);
		uart_write_blocking(c);
	}

	uart_put(c);
	while (1)
		;*/
/*
	int c;
	while (1)
	{
		c = uart_read_blocking();
		uart_put(c);

		print(c);
		uart_write_blocking(c);
	}

	char h[] = "Hello, world!\r\n";
	int strlen = 13;

	print(h);

	char in[32];
	for (int i = 0; i < 32; i++)
		in[i] = 0;

	readline(in, 32);
	print(in);

	char c;
	while (1)
	{
		c = uart_read_blocking();
		uart_write_blocking(c);
		uart_write_blocking(c);
	}*/
	return 0;
}
