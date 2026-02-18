#include "test.h"
#include "methods.h"
#include <chrono>
#include <iostream>

ComplexityMetrics measureTime(ComplexityMetrics (*func)()) {
  auto start = std::chrono::high_resolution_clock::now();
  ComplexityMetrics metrics = func();
  auto end = std::chrono::high_resolution_clock::now();

  std::chrono::duration<double, std::milli> duration = end - start;
  metrics.duration = duration.count();
  return metrics;
}

ComplexityMetrics testTimes(ComplexityMetrics (*func)(), int n) {
  ComplexityMetrics metrics;

  for (int i = 0; i < n; i++) {
    auto m = measureTime(func);
    metrics.moves += m.moves;
    metrics.comparisons += m.comparisons;
    metrics.total += m.total;
    metrics.duration += m.duration;
  }

  metrics.duration /= n;
  metrics.moves /= n;
  metrics.comparisons /= n;
  metrics.total /= n;

  return metrics;
}

ComplexityMetrics _testFirstMethodWorst() {
  char x[] = {'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodWorst() {
  char x[] = {'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

ComplexityMetrics _testFirstMethodMedium() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M',
              'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I',
              '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I', '_',
              '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I', '_', '_',
              'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodMedium() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M',
              'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I',
              '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I', '_',
              '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'M', 'I', '_', '_',
              'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

ComplexityMetrics _testFirstMethodBest() {
  char x[] = {'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
              'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodBest() {
  char x[] = {'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

void testFirstMethod(int n) {
  const char intent = '\t';
  std::cout << "testFirstMethod() for " << n << " runs:" << std::endl;
  std::cout << intent << "testFirstMethodWorst() statistics: "
            << testTimes(_testFirstMethodWorst, n).toString() << std::endl;
  std::cout << intent << "testFirstMethodMedium() statistics: "
            << testTimes(_testFirstMethodMedium, n).toString() << std::endl;
  std::cout << intent << "testFirstMethodBest() statistics: "
            << testTimes(_testFirstMethodBest, n).toString() << std::endl;
}

void testOtherMethod(int n) {
  const char intent = '\t';
  std::cout << "testOtherMethod() for " << n << " runs:" << std::endl;
  std::cout << intent << "testOtherMethodWorst() statistics: "
            << testTimes(_testOtherMethodWorst, n).toString() << std::endl;
  std::cout << intent << "testOtherMethodMedium() statistics: "
            << testTimes(_testOtherMethodMedium, n).toString() << std::endl;
  std::cout << intent << "testOtherMethodBest() statistics: "
            << testTimes(_testOtherMethodBest, n).toString() << std::endl;
}
