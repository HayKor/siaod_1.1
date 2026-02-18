#ifndef METHODS_H
#define METHODS_H

#include "util.h"
#include <cstddef>
#include <string>

ComplexityMetrics delFirstMethod(char *x, size_t &n, const char &key);
ComplexityMetrics delOtherMethod(char *x, size_t &n, const char &key);
char *generateRandomArray(size_t size, const char key, const char otherChar);

#endif // !METHODS_H
