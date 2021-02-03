#include <stdio.h>
#include <stdlib.h>

void invisible_func(int check)
{
    if (check != 0xDEADC0DE) {
        printf("Wrong!");
        exit(0);
    }
    printf("How did you found me?!\n");
}
