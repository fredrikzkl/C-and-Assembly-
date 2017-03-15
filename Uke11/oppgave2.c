#include <stdio.h>

extern int fak (int v);
extern int tester(int i);

int realfak(int v){
  int sum = 1;
  while(v != 0){
    sum *= v;
    v--;
  }
  return sum;
}

int main (void)
{
  int i = 5;

  printf("Fak(%d) = %d(%d)\n",i,fak(i),realfak(i));
  printf("Testprogram(%d) = %d\n",i,tester(i));
}
