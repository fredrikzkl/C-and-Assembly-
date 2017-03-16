#include <stdio.h>
#include <stdlib.h>

int hexval (unsigned char c)
{
    if(c == '0') return 0;
    if(c == '1') return 1;
    if(c == '2') return 2;
    if(c == '3') return 3;
    if(c == '4') return 4;
    if(c == '5') return 5;
    if(c == '6') return 6;
    if(c == '7') return 7;
    if(c == '8') return 8;
    if(c == '9') return 9;
    if(c == 'A' || c == 'a') return 10;
    if(c == 'B' || c == 'b') return 11;
    if(c == 'C' || c == 'c') return 12;
    if(c == 'D' || c == 'd') return 13;
    if(c == 'E' || c == 'e') return 14;
    if(c == 'F' || c == 'f') return 15;
}

/* Også vektorer kan initialiseres! */
unsigned char ca[5] = { '0', '4', 'A', 'b', 'f' };

int main (void)
{
  printf("INIT\n");
  int i;

  for (i = 0;  i < 5;  ++i)
    printf("hexval('%c') gir %d\n", ca[i], hexval(ca[i]));
  return 0;
}
