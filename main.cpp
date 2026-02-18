#include "test.h"
#include <iostream>

int main() {
  const auto runs = 1;

  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testFirstMethod(n, runs);
    std::cout << "---------" << std::endl;
    testOtherMethod(n, runs);
    std::cout << "---------" << std::endl;
    testBothMethodsMedium(n, runs);
    std::cout << "---------" << std::endl;
  }
  return 0;
}
