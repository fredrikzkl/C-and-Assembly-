#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char *my_strdup(char* s)
{
  char *c = malloc(strlen(s) + 1);
  if(c == NULL)
  {
    return NULL;
  }
  strcpy(c,s);
  return c;
}

int shortExample(short a, short b)
{
  //Siden short kun holder 16-bits tall, vil alle
  //Tall over 32767 bli feil
  //Feks i oppgaven 20000 + 20000 = >32767
  return a+b;
}

int main()
{




  return 0;
}
