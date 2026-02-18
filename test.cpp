#include "methods.h"
#include "util.h"
#include <cstring>
#include <iostream>

void testBothMethodsMedium(size_t n, int runs = 100) {
  char *arr = generateRandomArray(n, '_', 'A');
  char *copy = new char[n + 1];
  std::memcpy(copy, arr, n);

  auto testFirst = [&](size_t n) { return delFirstMethod(arr, n, '_'); };
  auto testOther = [&](size_t n) { return delOtherMethod(copy, n, '_'); };
  std::cout << "\ttestBothMethodsMedium() for " << runs
            << " runs: " << std::endl;
  std::cout << "\t\ttestFirstMethodMedium() statistics: "
            << measureTime(testFirst, n).toString() << std::endl;
  std::cout << "\t\ttestOtherMethodMedium() statistics: "
            << measureTime(testOther, n).toString() << std::endl;

  delete[] arr;
  delete[] copy;
}

void testFirstMethod(size_t n, int runs = 100) {
  std::cout << "\ttestFirstMethod() for " << runs << " runs:" << std::endl;
  std::cout << "\t\ttestFirstMethodWorst() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, '_', len);

                     return delFirstMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
  std::cout << "\t\ttestFirstMethodBest() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, 'A', len);

                     return delFirstMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
}

void testOtherMethod(size_t n, int runs = 100) {
  std::cout << "\ttestOtherMethod() for " << runs << " runs:" << std::endl;
  std::cout << "\t\ttestOtherMethodWorst() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, 'A', len);
                     return delOtherMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
  std::cout << "\t\ttestOtherMethodBest() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, '_', len);
                     return delOtherMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
}
