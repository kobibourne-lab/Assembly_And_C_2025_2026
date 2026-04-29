#include <stdio.h>
#include <assert.h>

/* pulls add_reg from main.asm */
extern int add_reg(int a, int b);

int main()
{
    printf("Tests add_reg from main.asm \n");

    /* addition test */
    assert(add_reg(1, 1) == 2);
    printf("PASS: 1 + 1 = 2\n");

    /*max range vals test */
    assert(add_reg(10000, 10000) == 20000);
    printf("PASS: 10000 + 10000 = 20000\n");

    /* 3 loops- like main.asm */
    int total = 0;
    total += add_reg(1, 2);    /* loop 1 */
    total += add_reg(3, 4);    /* loop 2 */
    total += add_reg(5, 6);    /* loop 3 */
    assert(total == 21);
    printf("Pass total = 21\n");

    printf("\nAll tests passed!\n");
    return 0;
}
