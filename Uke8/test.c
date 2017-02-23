#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int f(int a, int b);
extern int mul(int a);

int main()
{
  int a = 3;
  int b = 1;
  int c = 5;

  printf("\nF(%d,%d): %d\n",a,a,f(a,a));
  printf("F(%d,%d): %d\n",a,b,f(a,b));

  printf("MUL(%d): %d\n",a,mul(a));
  printf("MUL(%d): %d\n",b,mul(b));
  printf("MUL(%d): %d\n",c,mul(c));

  return 0;
}
