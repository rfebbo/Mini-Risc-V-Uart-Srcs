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

    while(j < 6)
    {
        uart_write_blocking(str2[j]);
        j++;
    }

    while (1)
        ;
}