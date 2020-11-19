int main(void)
{
	int i = 2;
	int j = i + 4;
	int k = i * j;

    volatile int * p = (int *)0xaaaaa008;
    *p = k;
}