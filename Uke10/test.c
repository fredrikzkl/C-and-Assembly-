#include <stdio.h>

extern int f1(int i);
extern int f2(int i);
extern int f3(int a, int b, int c);
extern int f4(int a, int b);

int main (void)
{

  int i = 5;

  int a = 2;
  int b = 2;
  int c = 10;

  printf("-Testprogram inititated-\n");
  printf("F1(%d): %d\n", i, f1(i));
  printf("F2(%d): %d\n", i, f2(i));

  printf("F3(%d,%d,%d): %d\n", a,b,c, f3(a,b,c));
  printf("F4(%d,%d): %d\n", a,b,f4(a,b));

}
