
#include "print.h"

int main(void)
{
    int j = -7;
    int k = 1000;
    int l = 0;

	for(int i = 0; i < 3; i++)
    {
        k /= j; // -142, 20, -2
    }

    l = k + 1; // -1

    for(int i = 0; i < 5; i++)
    {
        l *= j; // 7, -49, 343, -2401, 16807
    }

    l = l % k; // 1

    volatile int * p = (int *)0xaaaaa008;
    *p = l;
}