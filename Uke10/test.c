#include <stdio.h>

extern int f1(int i);
extern int f2(int i);
extern int f3(int a, int b, int c);
extern int f4(int a, int b);

extern int odd(int x);

extern unsigned int bit_not(unsigned int a);
extern unsigned int c_not(unsigned int a);
extern unsigned int bit_and(unsigned int a, unsigned int b);
extern unsigned int c_and(unsigned int a, unsigned int b);

void printBits(unsigned int n){
  while (n) {
    if (n & 1)
        printf("1");
    else
        printf("0");

    n >>= 1;
  }
  printf("\n");
}

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

  printf("Odd(%d): %d\n",a,odd(a));

  unsigned int not = 10;
  printf("bit_not(%d)\n",not);
  printBits(bit_not(not));

  unsigned int check = 1;
  printf("c_not(%d): %d\n",check,c_not(check));
  printf("bit_and(%d,%d): %d\n",not,check,bit_and(not,check));

  unsigned int a1 = 2, a2 = 1;
  printf("c_and(%d,%d): %d\n",a1,a2,c_and(a1,a2));




}
