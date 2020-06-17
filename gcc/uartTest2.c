#include "uart.h"
#include "print.h"

int main(void)
{
	int c = 65;
	int i = 0;
	for (i = 0; i < 5; i++)
	{
		print(c);
		uart_write_blocking(c);
	}

	while (1)
		;
}