#ifndef METHODS_H
#define METHODS_H

#include "util.h"
#include <cstddef>
#include <string>

ComplexityMetrics delFirstMethod(char *x, size_t &n, const char &key);
ComplexityMetrics delOtherMethod(char *x, size_t &n, const char &key);
ComplexityMetrics bubbleSort(int *arr, size_t n);
ComplexityMetrics insertionSort(int *arr, size_t n);
#endif // !METHODS_H
