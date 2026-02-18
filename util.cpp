#include "util.h"
#include <chrono>

ComplexityMetrics measureTime(TestFunc func, size_t len) {
  auto start = std::chrono::high_resolution_clock::now();
  ComplexityMetrics metrics = func(len);
  auto end = std::chrono::high_resolution_clock::now();

  std::chrono::duration<double, std::milli> duration = end - start;
  metrics.duration = duration.count();
  return metrics;
}

ComplexityMetrics testTimes(TestFunc func, int n, size_t len) {
  ComplexityMetrics metrics;

  for (int i = 0; i < n; i++) {
    auto m = measureTime(func, len);
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
