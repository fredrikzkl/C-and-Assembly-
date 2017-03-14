
#include <stdio.h>

extern int fak (int v);

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
  int i = 4;

  printf("Fak(%d) = %d(%d)\n",i,fak(i),realfak(i));
}
