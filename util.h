#ifndef UTIL_H
#define UTIL_H

#include <cstddef>
#include <functional>
#include <string>

struct ComplexityMetrics {
  size_t comparisons; // Сп — число сравнений
  size_t moves;       // Мп — число перемещений
  size_t total;       // Тп = Сп + Мп
  double duration;

  ComplexityMetrics() : comparisons(0), moves(0), total(0), duration(0) {}

  std::string toString() const {
    return "Сп=" + std::to_string(comparisons) +
           ", Мп=" + std::to_string(moves) + ", Тп=" + std::to_string(total) +
           ", took " + std::to_string(duration) + " ms";
  }
};

using TestFunc = std::function<ComplexityMetrics(size_t)>;

ComplexityMetrics measureTime(TestFunc func, size_t len);
ComplexityMetrics testTimes(TestFunc func, int n, size_t len);
#endif // !UTIL_H
