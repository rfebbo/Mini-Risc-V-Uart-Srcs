int nothing()
{
    return 1;
}

void print(int a)
{
    volatile int *p = (int *)0xaaaaa008;
    *p = a;
}

int res(int a)
{
    return a;
}

int main(void)
{
    int num = 1;
    int i = 0;

    int temp = 1;

    for (i = 0; i < 3; i++)
    {
        num = 2;
    }

    int result = res(num);
    
    while(1);
}