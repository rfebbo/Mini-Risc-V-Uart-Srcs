void print(int a)
{
    volatile int * p = (int *)0xaaaaa008;
    *p = a;
}

int main(void)
{
	int i = 2 + 3;
	int j = 1 + i;
	print(j);
}