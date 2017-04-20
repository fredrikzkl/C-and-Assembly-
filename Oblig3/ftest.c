#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

#define FALSE 0
#define TRUE  1

typedef unsigned char byte;

extern void writebyte(FILE *f, byte b);

void error (char *message)
{
  printf("\nERROR: %s\n", message);
  exit(1);
}

//Test 1
byte b_seq_1[] = { 4, 0, 255, 17, 200 };

void test_1 (void)
{
  int n_bytes = sizeof(b_seq_1)/sizeof(b_seq_1[0]);
  int i;
  FILE *f = fopen("test1.txt", "wb");
  if (f == NULL) error("Could not create test1.txt!");
  //printf("For loop goes here:\n");
  for (i = 0;  i < n_bytes;  i++){
    printf("\nTrying to add: %d\n" + b_seq_1[i]);
    writebyte(f, b_seq_1[i]);
  }
  fclose(f);

  //test_byte_file("test1.txt", b_seq_1, n_bytes);
}

int main(void)
{
    printf("Test Initiated\n");
    test_1();

}
