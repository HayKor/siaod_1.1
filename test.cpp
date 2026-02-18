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

ComplexityMetrics _testFirstMethodShort() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodShort() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

ComplexityMetrics _testFirstMethodMedium() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodMedium() {
  char x[] = {'_', 'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

ComplexityMetrics _testFirstMethodLong() {
  char x[] = {'_', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'I',
              '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'I', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 'E',
              'A', '_', '_', '_', '_', '_', '_', '_', 'E', 'A', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 'E',
              'A', '_', '_', '_', 'M', 'I', '_', '_', 'R', '_', '_', '_',
              '_', '_', 'M', 'I', '_', '_', 'R', '_', '_', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delFirstMethod(x, n, '_');
}

ComplexityMetrics _testOtherMethodLong() {
  char x[] = {'_', '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'I',
              '_', '_', 'R', '_', '_', 'E', 'A', '_', '_', '_', 'I', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 'E',
              'A', '_', '_', '_', '_', '_', '_', '_', 'E', 'A', '_', '_',
              '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 'E',
              'A', '_', '_', '_', 'M', 'I', '_', '_', 'R', '_', '_', '_',
              '_', '_', 'M', 'I', '_', '_', 'R', '_', '_', '_', '_', '_',
              'M', 'I', '_', '_', 'R', '_', '_', '_', '_', '\0'};
  size_t n = sizeof(x);

  return delOtherMethod(x, n, '_');
}

void testFirstMethod() {
  const char intent = '\t';
  std::cout << "testFirstMethod():" << std::endl;
  std::cout << intent << "testFirstMethodShort() statistics: "
            << measureTime(_testFirstMethodShort).toString() << std::endl;
  std::cout << intent << "testFirstMethodMedium() statistics: "
            << measureTime(_testFirstMethodMedium).toString() << std::endl;
  std::cout << intent << "testFirstMethodLong() statistics: "
            << measureTime(_testFirstMethodLong).toString() << std::endl;
}

void testOtherMethod() {
  const char intent = '\t';
  std::cout << "testOtherMethod():" << std::endl;
  std::cout << intent << "testOtherMethodShort() statistics: "
            << measureTime(_testOtherMethodShort).toString() << std::endl;
  std::cout << intent << "testOtherMethodMedium() statistics: "
            << measureTime(_testOtherMethodMedium).toString() << std::endl;
  std::cout << intent << "testOtherMethodLong() statistics: "
            << measureTime(_testOtherMethodLong).toString() << std::endl;
}
