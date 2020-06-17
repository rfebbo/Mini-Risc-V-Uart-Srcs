#include"uart.h"
#include"utils.h"

int nothing()
{
    return 1;
}

int main(void)
{
    char str[20] = "Hello.";
    int i = 0;
    for (i = 0; i < 6; i++)
    {
        uart_write_blocking(str[i]);
    }

    int num = nothing();

    for(i = 0; i < 6; i++)
    {
        uart_write_blocking(str[i]);
    }

    while (1)
        ;
}