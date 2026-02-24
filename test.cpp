#include "include/methods.h"
#include "include/util.h"
#include <cstring>
#include <iostream>

void testBothSortWorst(size_t n) {
  int *arr = new int[n];
  int *copy = new int[n];
  for (int i = 0; i < n; i++) {
    arr[i] = n - i;
  }
  std::memcpy(copy, arr, n * sizeof(int));
  auto testInsertion = [&](size_t n) { return insertionSort(arr, n); };
  auto testBubble = [&](size_t n) { return bubbleSort(copy, n); };
  std::cout << "\t\ttestBubbleSortWorst() statistics: "
            << measureTime(testBubble, n).toString() << std::endl;
  std::cout << "\t\ttestInsertionSortWorst() statistics: "
            << measureTime(testInsertion, n).toString() << std::endl;
  delete[] arr;
  delete[] copy;
}

void testBothSortBest(size_t n) {
  int *arr = new int[n];
  int *copy = new int[n];
  for (int i = 0; i < n; i++) {
    arr[i] = i;
  }
  std::memcpy(copy, arr, n * sizeof(int));
  auto testInsertion = [&](size_t n) { return insertionSort(arr, n); };
  auto testBubble = [&](size_t n) { return bubbleSort(copy, n); };
  std::cout << "\t\ttestBubbleSortBest() statistics: "
            << measureTime(testBubble, n).toString() << std::endl;
  std::cout << "\t\ttestInsertionSortBest() statistics: "
            << measureTime(testInsertion, n).toString() << std::endl;
  delete[] arr;
  delete[] copy;
}

void testBothSortMedium(size_t n) {
  int *arr = generateRandomIntArray(n);
  int *copy = new int[n];
  std::memcpy(copy, arr, n * sizeof(int));
  auto testInsertion = [&](size_t n) { return insertionSort(arr, n); };
  auto testBubble = [&](size_t n) { return bubbleSort(copy, n); };
  std::cout << "\t\ttestBubbleSortMedium() statistics: "
            << measureTime(testBubble, n).toString() << std::endl;
  std::cout << "\t\ttestInsertionSortMedium() statistics: "
            << measureTime(testInsertion, n).toString() << std::endl;
  delete[] arr;
  delete[] copy;
}

void testBothSort(size_t n) {
  std::cout << "\ttestBothSortBest(): " << std::endl;
  testBothSortBest(n);
  std::cout << "\ttestBothSortMedium(): " << std::endl;
  testBothSortMedium(n);
  std::cout << "\ttestBothSortWorst(): " << std::endl;
  testBothSortWorst(n);
}

void testBubbleSortWorst(size_t n) {
  int *arr = new int[n];
  for (int i = 0; i < n; i++) {
    arr[i] = n - i;
  }
  auto test = [&](size_t n) { return bubbleSort(arr, n); };
  std::cout << "\t\ttestBubbleSortWorst statistics: "
            << measureTime(test, n).toString() << std::endl;
}

void testBubbleSortBest(size_t n) {
  int *arr = new int[n];
  for (int i = 0; i < n; i++)
    arr[i] = i;
  auto test = [&](size_t n) { return bubbleSort(arr, n); };
  std::cout << "\t\ttestBubbleSortBest statistics: "
            << measureTime(test, n).toString() << std::endl;
}

void testBubbleSortMedium(size_t n) {
  int *arr = generateRandomIntArray(n);
  auto test = [&](size_t n) { return bubbleSort(arr, n); };
  std::cout << "\t\ttestBubbleSortMedium() statistics: "
            << measureTime(test, n).toString() << std::endl;

  delete[] arr;
}

void testBubbleSort(size_t n) {
  testBubbleSortBest(n);
  testBubbleSortWorst(n);
}

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
