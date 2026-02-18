#include "methods.h"

ComplexityMetrics delFirstMethod(char *x, size_t &n, const char &key) {
  ComplexityMetrics metrics;
  size_t i = 0;

  while (i < n) {
    metrics.comparisons++; // Сравнение x[i] == key
    if (x[i] == key) {
      for (size_t j = i; j < n - 1; j++) {
        metrics.moves++; // Перемещение x[j] = x[j + 1]
        x[j] = x[j + 1];
      }
      n--;
    } else {
      i++;
    }
  }
  metrics.total = metrics.comparisons + metrics.moves;
  return metrics;
}

ComplexityMetrics delOtherMethod(char *x, size_t &n, const char &key) {
  ComplexityMetrics metrics;
  size_t j = 0;

  for (size_t i = 0; i < n; i++) {
    metrics.comparisons++; // Сравнение x[i] != key
    if (x[i] != key) {
      if (i != j) {
        metrics.moves++; // Перемещение x[j] = x[i]
        x[j] = x[i];
      }
      j++;
    }
  }
  n = j;

  metrics.total = metrics.comparisons + metrics.moves;
  return metrics;
}
