#include <stdio.h>

typedef unsigned int uint;

extern uint bit_not (uint a);
extern uint c_not (uint a);
extern uint bit_and (uint a, uint b);
extern uint c_and (uint a, uint b);

uint data[] = { 0, 1, 4 };

int main (void)
{
  int i, j, n_data = sizeof(data)/sizeof(data[0]);

  for (i = 0;  i < n_data;  i++) {
    printf("NOT %u == %u == 0x%x    ", data[i], bit_not(data[i]), bit_not(data[i]));
    printf("! %u == %u\n", data[i], c_not(data[i]));

    for (j = 0;  j < n_data;  j++) {
      printf("%u AND %u == %u    ", data[i], data[j], bit_and(data[i],data[j]));
      printf("%u && %u == %u\n", data[i], data[j], c_and(data[i],data[j]));
    }
  }
}
