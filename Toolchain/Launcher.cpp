#include "Memory.h"
#include "Natives.h"
#include "Runtime.h"
#include "KString.h"
#include "Types.h"

#include <stdlib.h>
#include <stdio.h>
#include <string>
#include "utf8.h"

extern "C" KString kotlin_main();

extern "C" const char* kotlin_wrapper() {
  RuntimeState* state = InitRuntime();

  if (state == nullptr) {
    return "Failed to initialize the kotlin runtime";
  }

  KString exitMessage;
  {
    ObjHolder args;
    exitMessage = kotlin_main();
  }

  const KChar* utf16 = CharArrayAddressOfElementAt(exitMessage, 0);
  std::string utf8;
  utf8::utf16to8(utf16, utf16 + exitMessage->count_, back_inserter(utf8));

  DeinitRuntime(state);

  const char *cString = utf8.c_str();
  char *returnMessage = (char *)malloc(strlen(cString) * sizeof(char*));
  strcpy(returnMessage, cString);

  return returnMessage;
}
