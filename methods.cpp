#include "include/methods.h"

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

ComplexityMetrics bubbleSort(int *arr, size_t n) {
  ComplexityMetrics metrics;

  bool swapped;
  for (size_t i = 0; i < n - 1; ++i) {
    swapped = false;
    for (size_t j = 0; j < n - 1 - i; ++j) {
      metrics.comparisons++;

      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;

        metrics.moves += 3;
        swapped = true;
      }
    }
    if (!swapped)
      break;
  }

  metrics.total = metrics.comparisons + metrics.moves;
  return metrics;
}

ComplexityMetrics insertionSort(int *arr, size_t n) {
  ComplexityMetrics metrics;

  for (size_t i = 1; i < n; ++i) {
    int key = arr[i];
    int j = static_cast<int>(i - 1);

    while (j >= 0) {
      metrics.comparisons++;
      if (arr[j] > key) {
        arr[j + 1] = arr[j];
        metrics.moves++;
        j--;
      } else {
        break;
      }
    }

    arr[j + 1] = key;
    metrics.moves++;
  }

  metrics.total = metrics.comparisons + metrics.moves;
  return metrics;
}
