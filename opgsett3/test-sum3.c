#include <stdio.h>

extern int sum3(int a, int b, int c);
<<<<<<< HEAD
extern int f(int a, int b, int c);
extern int intcmp(int a, int b);

int main()
{

  int a1 = 1;
  int a2 = 2;
  int a3 = 3;

  printf("\n--Testprogram  INITIATED--\nSum3(%d,%d,%d): [%d]",a1,a2,a3,sum3(a1,a2,a3));
  //Oppgave 2
  printf("\nf(%d,%d,%d): [%d]\n",a1,a2,a3,f(a1,a2,a3));
  printf("-Comparetest-\n");
  printf("intcmp(%d,%d):[%d]\n",a1,a2,intcmp(a1,a2));
  printf("intcmp(%d,%d):[%d]\n",a3,a2, intcmp(a3,a2));
  printf("intcmp(%d,%d):[%d]\n",a3,a1, intcmp(a3,a1));
  printf("intcmp(%d,%d):[%d]\n",a3,a3, intcmp(a3,a3));

  printf("\n");

  return 0;
}
