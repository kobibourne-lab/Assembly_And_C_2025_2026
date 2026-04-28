#include <stdio.h>

int add(int a, int b) 
{
    return a + b;
}

int validate_input(int *num)
{
    // check input is 1 int
    if (scanf("%d", num) != 1)
    {
        // clear invalid input so its not read twice  
        while (getchar() != '\n');
        printf("Invalid input! Numbers only.\n");
        return 0;   // num invalid
    }
    // check num in range 
    if (*num < 0 || *num > 1000)
    {
        printf("Number out of range! Enter between 0 and 1000.\n");
        return 0;
    }
    return 1;   // number valid 
}

int main() 
{
    int total = 0;
    int i = 0;
    for (i = 0; i < 3; i++) 
    {
        int x, y;

        printf("Enter number: ");
        while (validate_input(&x) == 0)     // keep asking until valid
        {
            printf("Enter number: ");
        }

        printf("Enter number: ");
        while (validate_input(&y) == 0)
        {
            printf("Enter number: ");
        }

        int result = add(x, y);
        total = total + result;

        printf("The sum is: %d\n", result);
    }

    printf("Final sum is: %d\n", total);

    return 0;
}
