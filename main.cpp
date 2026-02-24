#include "include/test.h"
#include <iostream>

int main() {
  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000,
                 1000000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testBothSort(n);
    std::cout << "---------" << std::endl;
  }
  return 0;
}
