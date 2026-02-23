#include "include/methods.h"
#include "include/test.h"
#include "include/util.h"
#include <iostream>

int main() {
  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000,
                 1000000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testBubbleSort(n);
    std::cout << "---------" << std::endl;
  }
  // const int n = 10;
  // int *arr = new int[n];
  // for (int i = 0; i < n; i++) {
  //   arr[i] = n - i;
  // }
  // for (int i = 0; i < n; i++)
  //   std::cout << " " << arr[i];
  // std::cout << std::endl;
  // bubbleSort(arr, n);
  // for (int i = 0; i < n; i++)
  //   std::cout << " " << arr[i];
  // std::cout << std::endl;
  //
  // delete[] arr;
  return 0;
}
