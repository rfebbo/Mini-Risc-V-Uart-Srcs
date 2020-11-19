void print(int a)
{
    volatile int * p = (int *)0xaaaaa008;
    *p = a;
}

int main(void)
{
	int temp = 2;
	for(int i = 1; i < 3; i++)
	{
		temp *= i;		
	}
	print(temp);
}