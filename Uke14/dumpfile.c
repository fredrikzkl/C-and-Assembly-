#include <stdio.h>

int readbyte (FILE *f)
{
  int status;
  unsigned char c;

  status = fread(&c, 1, 1, f);
  if (status <= 0) return -1;
  return (int)c;
}

int main(){

}
