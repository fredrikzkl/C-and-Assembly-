
#include <stdio.h>

extern int n_ones (unsigned int v);

int main (void)
{
  unsigned int i;

  for (i = 0;  i <= 100;  i += 13)
    printf("0x%02x har %d 1-er-bit\n", i, n_ones(i));
  return 0;
}
