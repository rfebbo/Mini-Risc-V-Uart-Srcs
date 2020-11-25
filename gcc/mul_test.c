int main(void)
{
	int i = 2;
	int j = i * 4; // 8
	int k = i * j; // 16
	j = k * -6; // -96
	k = k * j; // -1536

    volatile int * p = (int *)0xaaaaa008;
    *p = k;
}