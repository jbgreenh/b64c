#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int LLVMFuzzerTestOneInput(char* data, size_t size)
{
  unsigned char *str = data;
  char *enc = b64_encode(str, size);
  char *dec = b64_decode(enc, strlen(enc));

  free(enc);
  free(dec);
  return 0;
}