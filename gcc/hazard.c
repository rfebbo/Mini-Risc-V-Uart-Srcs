void print(int a)
{
    volatile int *p = (int *)0xaaaaa008;
    *p = a;
}

int nothing()
{
    return 1;
}

int res(int a)
{
    return a;
}

int main(void)
{
    int num = 1;
    
    int i = 0;

    int temp = nothing(num);

    for (i = 0; i < 3; i++)
    {
        num += 1;
    }

    int result = res(num);

    print(result);

    while(1);
}