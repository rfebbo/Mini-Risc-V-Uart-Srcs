#define INT_OFFSET 48

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

void itoa(int a, char *c)
{
	int idx = 0;

	c[idx] = a + INT_OFFSET;
    c[idx + 1] = '\0';
}

int strlen(char c[])
{
	char *ptr = &c[0];

	int offset = 0;
	while (*(ptr + offset) != '\0')
	{
		offset++;
	}

	return offset;
}

void uart_print(char c[])
{
	int len = strlen(c);
	for (int i = 0; i < len; i++)
	{
		uart_write_blocking(c[i]);
	}
}

int main(void)
{
    unsigned char buffer[20];

    itoa(2, buffer);
    uart_print(buffer);
    itoa(3, buffer);
    uart_print(buffer);

    return 0;
}