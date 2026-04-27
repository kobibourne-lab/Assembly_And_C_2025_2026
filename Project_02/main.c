#include <stdio.h>

int add(int a, int b) 
{
    return a + b;
}

int main() 
{
    int total = 0;
    int i = 0;
    for (i = 0; i < 3; i++) 
{
        int x, y;

        printf("Enter number: ");
        scanf("%d", &x);

        printf("Enter number: ");
        scanf("%d", &y);

        int result = add(x, y);
        total = total + result;

        printf("The sum is: %d\n", result);
    }

    printf("Final sum is: %d\n", total);

    return 0;
}
