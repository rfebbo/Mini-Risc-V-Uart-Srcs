#include"uart.h"
#include"utils.h"

int nothing()
{
    return 1;
}

int main(void)
{
    char str[20] = "Hello.";
    char str2[20] = "Hello.";
    int i = 0;
    int j = 0;
    for (i = 0; i < 6; i++)
    {
        uart_write_blocking(str[i]);
    }

    int num = nothing();

    for(j = 0; j < 6; j++)
    {
        uart_write_blocking(str2[j]);
    }

    while (1)
        ;
}