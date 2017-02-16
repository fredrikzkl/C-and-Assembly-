#include <stdio.h>
#include <string.h>

int is_opt(unsigned char s[]){
    if(s[0] == '-'){
      printf("Tre");
      return 1;
    }
    return 0;
}

void strcatc (char s[], char c)
{
  int len = sizeof(s);

  for(int i = 0; i < len ; ++i){
    if(s[i] == 0){
      s[i] = c;
      return;
    }
  }
  //If the chararray is full
  char new[len+1];
  for(int i = 0; i < len ; ++i){
    new[i] = s[i];
  }
  new[len] = c;
}

char teststr[20];

void test (char c)
{
  printf("Foer: \"%s\".", teststr);
  strcatc(teststr, c);
  printf("\tEtter innsetting av '%c': \"%s\".\n", c, teststr);
}

int main (void)
{
  strcpy(teststr, "");  /* Initiering er noedvendig! */
  test('a');  test('b');  test('c');
  test('.');  test('.');  test('z');
  return 0;
}
