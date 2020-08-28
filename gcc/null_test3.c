#include "uart.h"

void print(int a)
{
    volatile int * p = (int *)0xaaaaa008;
    *p = a;
}

void test(char c[])
{
    int i = 0;

    c[i] = 'a';
    c[i + 1] = '\0';
}

int main(void)
{
    char c[10] = "Hello!!!"; // length of 8
    
    test(c);

    uart_print(c);
/*
    int i = 0;

    c[i] = 'a';
    c[i + 1] = '\0';
*/
    print(strlen(c)); // If function, returns 8. If main, returns 1.
    
    while(1);
}