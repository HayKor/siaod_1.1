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
  std::cout << "testBothMethodsMedium() for " << runs << " runs: " << std::endl;
  std::cout << "\ttestFirstMethodMedium() statistics: "
            << measureTime(testFirst, n).toString() << std::endl;
  std::cout << "\ttestOtherMethodMedium() statistics: "
            << measureTime(testOther, n).toString() << std::endl;

  delete[] arr;
  delete[] copy;
}

void testFirstMethod(size_t n, int runs = 100) {
  std::cout << "testFirstMethod() for " << runs << " runs:" << std::endl;
  std::cout << "\ttestFirstMethodWorst() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, '_', len);

                     return delFirstMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
  std::cout << "\ttestFirstMethodBest() statistics: "
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
  std::cout << "testOtherMethod() for " << runs << " runs:" << std::endl;
  std::cout << "\ttestOtherMethodWorst() statistics: "
            << testTimes(
                   [](size_t len) {
                     char x[len];
                     std::memset(x, 'A', len);
                     return delOtherMethod(x, len, '_');
                   },
                   runs, n)
                   .toString()
            << std::endl;
  std::cout << "\ttestOtherMethodBest() statistics: "
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
