#include "methods.h"
#include "util.h"
#include <cstring>
#include <iostream>

ComplexityMetrics _testFirstMethodWorst(size_t len) {
  char x[len];
  std::memset(x, '_', len);

  return delFirstMethod(x, len, '_');
}

ComplexityMetrics _testOtherMethodWorst(size_t len) {
  char x[len];
  std::memset(x, 'A', len);

  return delOtherMethod(x, len, '_');
}

ComplexityMetrics _testFirstMethodMedium(size_t len) {
  char *arr = generateRandomArray(len, '_', 'A');

  return delFirstMethod(arr, len, '_');
}

ComplexityMetrics _testOtherMethodMedium(size_t len) {
  char *arr = generateRandomArray(len, '_', 'A');

  return delOtherMethod(arr, len, '_');
}

ComplexityMetrics _testFirstMethodBest(size_t len) {
  char x[len];
  std::memset(x, 'A', len);

  return delFirstMethod(x, len, '_');
}

ComplexityMetrics _testOtherMethodBest(size_t len) {
  char x[len];
  std::memset(x, '_', len);

  return delOtherMethod(x, len, '_');
}

void testFirstMethod(int n) {
  const char intent = '\t';
  std::cout << "testFirstMethod() for " << n << " runs:" << std::endl;
  std::cout << intent << "testFirstMethodWorst() statistics: "
            << testTimes(_testFirstMethodWorst, n, 100).toString() << std::endl;
  std::cout << intent << "testFirstMethodMedium() statistics: "
            << testTimes(_testFirstMethodMedium, n, 100).toString()
            << std::endl;
  std::cout << intent << "testFirstMethodBest() statistics: "
            << testTimes(_testFirstMethodBest, n, 100).toString() << std::endl;
}

void testOtherMethod(int n) {
  const char intent = '\t';
  std::cout << "testOtherMethod() for " << n << " runs:" << std::endl;
  std::cout << intent << "testOtherMethodWorst() statistics: "
            << testTimes(_testOtherMethodWorst, n, 100).toString() << std::endl;
  std::cout << intent << "testOtherMethodMedium() statistics: "
            << testTimes(_testOtherMethodMedium, n, 100).toString()
            << std::endl;
  std::cout << intent << "testOtherMethodBest() statistics: "
            << testTimes(_testOtherMethodBest, n, 100).toString() << std::endl;
}
