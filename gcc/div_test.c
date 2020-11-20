int main(void)
{
    int j = -7;
    int k = 1000;
    int l = 0;

	for(int i = 0; i < 3; i++)
    {
        k /= j;
    }

    l = k + 1;

    for(int i = 0; i < 5; i++)
    {
        l *= j;
    }

    l = l % k;

    volatile int * p = (int *)0xaaaaa008;
    *p = l;
}