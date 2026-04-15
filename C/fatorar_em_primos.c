#include <stdio.h>

void fatoracao_prima(int n) 
{
    while (n % 2 == 0)
    {
        printf("2 ");
        n /= 2;
    }

    for (int i = 3; i * i <= n; i += 2)
    {
        while (n % i == 0)
        {
            printf("%d ", i);
            n /= i;
        }
    }

    if (n > 2)
    {
        printf("%d", n);
    }
}


int main()
{
    int n;

    printf("Digite um numero: ");
    scanf("%d", &n);

    if (n < 2)
    {
        printf ("Digite um numero maior que 1");
        return 1;
    }

    printf("Fatores primos de %d: ", n);
    fatoracao_prima(n);
    printf("\n");

    return 0;
}
