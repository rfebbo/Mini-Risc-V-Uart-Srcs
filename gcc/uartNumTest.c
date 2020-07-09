void uart_put(char c)
{
	volatile char *p = (char *)0xaaaaa400;
	*p = c;
}

char uart_poll()
{
	volatile char *p = (char *)0xaaaaa404;

	return *p;
}

void uart_write_blocking(char c)
{
	char s;
	do
	{
		s = uart_poll() & 2;
	} while (s != 0);

	uart_put(c);
}

int main(void)
{
    uart_write_blocking('1');
    uart_write_blocking('2');
    uart_write_blocking('3');
    uart_write_blocking('4');
    uart_write_blocking('5');
    uart_write_blocking('6');
    uart_write_blocking('7');
    uart_write_blocking('8');
    uart_write_blocking('9');
    uart_write_blocking('a');
    uart_write_blocking('b');
    uart_write_blocking('c');
    uart_write_blocking('d');
    uart_write_blocking('e');
    uart_write_blocking('f');
    uart_write_blocking('g');
    uart_write_blocking('h');
    uart_write_blocking('i');
    uart_write_blocking('j');
    uart_write_blocking('k');
    uart_write_blocking('l');
    uart_write_blocking('m');
    uart_write_blocking('n');
    uart_write_blocking('o');
    uart_write_blocking('p');
    uart_write_blocking('q');
    uart_write_blocking('r');
    uart_write_blocking('s');
    uart_write_blocking('t');
    uart_write_blocking('u');
    uart_write_blocking('v');
    uart_write_blocking('w');
    uart_write_blocking('x');
    uart_write_blocking('y');
    uart_write_blocking('z');
    uart_write_blocking('!');

    return 0;
}