#include <stdio.h>

extern int sum3(int a, int b, int c);

int main()
{
  int a1 = 1;
  int a2 = 2;
  int a3 = 3;
  printf("--Testprogram  INITIATED--\nSum3(%d,%d,%d)result: %d",a1,a2,a3,sum3(a1,a2,a3));

  

  return 0;
}
