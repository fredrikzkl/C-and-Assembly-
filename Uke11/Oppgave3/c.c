#include <stdio.h>

typedef unsigned long ulong;

extern ulong mod60 (ulong v);

int main (void)
{
  long x;

  for (x = 0;  x <= 200;  x += 17) {
    printf("%ld 'modulo' 60 = %ld\n", x, mod60(x));
  }
}
