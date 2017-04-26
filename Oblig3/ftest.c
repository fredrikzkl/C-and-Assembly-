#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

#define FALSE 0
#define TRUE  1

typedef unsigned char byte;
typedef unsigned long unicode;

extern void writebyte(FILE *f, byte b);
extern void writeutf8char (FILE *f, unicode u);

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
    writebyte(f, b_seq_1[i]);
  }
  fclose(f);

  //test_byte_file("test1.txt", b_seq_1, n_bytes);
}

/* Test #2 */
//unicode u_seq_2[] = { 0x24, 0x20, 0x41, 0x3d, 0x32, 0x78 };  /* "$ A=2x" */
unicode u_seq_2[] = { 0x24 };  /* "$ A=2x" */

byte    b_seq_2[] = { '$', ' ', 'A', '=', '2', 'x' };

void test_2 (void)
{
  int n_u = sizeof(u_seq_2)/sizeof(u_seq_2[0]);
  int n_b = sizeof(b_seq_2)/sizeof(b_seq_2[0]);
  int i;
  FILE *f = fopen("test2.txt", "wb");
  if (f == NULL) error("Could not create test2.txt!");

  for (i = 0;  i < n_u;  i++)
    writeutf8char(f, u_seq_2[i]);
  fclose(f);

  //test_byte_file("test2.txt", b_seq_2, n_b);
}

int main(void)
{
    printf("Test Initiated\n");
    test_1();
    test_2();

}
