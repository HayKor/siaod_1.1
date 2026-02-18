#include "test.h"
#include <iostream>

int main() {
  testFirstMethod(100, 1);
  std::cout << "---------" << std::endl;
  testOtherMethod(100, 1);
  std::cout << "---------" << std::endl;
  testBothMethodsMedium(100, 1);
  return 0;
}
