#ifndef METHODS_H
#define METHODS_H

#include <cstddef>
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
ComplexityMetrics delFirstMethod(char *x, size_t &n, const char &key);
ComplexityMetrics delOtherMethod(char *x, size_t &n, const char &key);

#endif // !METHODS_H
