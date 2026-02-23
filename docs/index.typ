#import "config.typ": *
#show: template

*Цель работы:* актуализация знаний и приобретение практических умений и навыков
по определению вычислительной сложности алгоритмов (эмпирический подход).

= Задание 1
== Начало
Определим структуру `ComplexityMetrics` для подсчета числа выполненных сравнений ($С_п$) + перемещений элементов в памяти ($М_п$), а также суммарное
число критических операций $Т_п$= $С_п$ + $М_п$.

```cpp
struct ComplexityMetrics {
  size_t comparisons; // Сп — число сравнений
  size_t moves;       // Мп — число перемещений
  size_t total;       // Тп = Сп + Мп
  double duration;    // время выполнения функции (мс)

  ComplexityMetrics() : comparisons(0), moves(0), total(0), duration(0) {}

  std::string toString() const {
    return "Сп=" + std::to_string(comparisons) +
           ", Мп=" + std::to_string(moves) + ", Тп=" + std::to_string(total) +
           ", took " + std::to_string(duration) + " ms";
  }
};
```

Определим функцию для подсчета времени выполнения алгоритма:
```cpp
#include <chrono>

using TestFunc = std::function<ComplexityMetrics(size_t)>;

ComplexityMetrics measureTime(TestFunc func, size_t len) {
  auto start = std::chrono::high_resolution_clock::now();
  ComplexityMetrics metrics = func(len);
  auto end = std::chrono::high_resolution_clock::now();

  std::chrono::duration<double, std::milli> duration = end - start;
  metrics.duration = duration.count();
  return metrics;
}
```
Функция принимает функцию, соответствующую типу `ComplexityMetrics (size_t)`, и возвращает метрику.

Определим функцию для генерации рандомно заполненного массива:
```cpp 
#include <random>

static std::mt19937 rng(std::random_device{}());

char *generateRandomArray(size_t size, const char key, const char otherChar) {
  char *arr = new char[size + 1];

  std::bernoulli_distribution dist(0.5);

  for (size_t i = 0; i < size; i++) {
    arr[i] = dist(rng) ? key : otherChar;
  }
  arr[size] = '\0';
  return arr;
}
```
Функция возвращает указатель на динамически аллоцированный массив символов длинной `size+1` (послдений элемент массива под `'\0'`), заполненный символами `key` (символ к удалению) и `otherChar`.

== Алгоритм №1
Реализуем первый метод на языке C++:
```cpp
void delFirstMethod(char *x, size_t &n, const char &key) {
  size_t i = 0;

  while (i < n) {
    if (x[i] == key) {
      for (size_t j = i; j < n - 1; j++) {
        x[j] = x[j + 1];
      }
      n--;
    } else {
      i++;
    }
  }
}
```

Изменим код реализованного метода для возвращения метрик:

```cpp
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
```
Теперь функция возвращает метрику.

=== Тестирование алгоритма
Протестируем функцию в 3х случаях (лучший, худший и средний) на массивах длинной _n = 100, 200, 500, 1000, 2000, 5000, 10000_
```cpp
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
```

Определим функцию для тестирования алгоритма в среднем (случайном) случае:
#figure(
```cpp
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
```,
  caption: [Общая функция проверки алгоритмов в среднем (случайном) случае.]
) <medium>

Функция в данной реализации тестирует оба алгоритма на одном и том же массивe для точности сравнения. Дальше мы просто проигнорируем вывод тестирования для второго алгоритма.

Теперь в файле `main.cpp` вызовем методы для тестирования первого алгоритма:
```cpp
#include "include/test.h"
#include <iostream>

int main() {
  const auto runs = 1;

  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testFirstMethod(n, runs);
    std::cout << "---------" << std::endl;
    testBothMethodsMedium(n, runs);
    std::cout << "---------" << std::endl;
  }
  return 0;
}
```

Вывод программы:
```shell
RUNNING FOR N=100
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=100, Мп=4950, Тп=5050, took 0.028183 ms
		testFirstMethodBest() statistics: Сп=100, Мп=0, Тп=100, took 0.000802 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=100, Мп=2266, Тп=2366, took 0.013666 ms
---------

RUNNING FOR N=200
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=200, Мп=19900, Тп=20100, took 0.100721 ms
		testFirstMethodBest() statistics: Сп=200, Мп=0, Тп=200, took 0.001143 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=200, Мп=8564, Тп=8764, took 0.047741 ms
---------

RUNNING FOR N=500
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=500, Мп=124750, Тп=125250, took 0.606165 ms
		testFirstMethodBest() statistics: Сп=500, Мп=0, Тп=500, took 0.002314 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=500, Мп=61134, Тп=61634, took 0.302020 ms
---------

RUNNING FOR N=1000
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=1000, Мп=499500, Тп=500500, took 2.427775 ms
		testFirstMethodBest() statistics: Сп=1000, Мп=0, Тп=1000, took 0.004569 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=1000, Мп=254091, Тп=255091, took 1.250503 ms
---------

RUNNING FOR N=2000
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=2000, Мп=1999000, Тп=2001000, took 9.523869 ms
		testFirstMethodBest() statistics: Сп=2000, Мп=0, Тп=2000, took 0.007865 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=2000, Мп=1005082, Тп=1007082, took 4.767976 ms
---------

RUNNING FOR N=5000
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=5000, Мп=12497500, Тп=12502500, took 59.287127 ms
		testFirstMethodBest() statistics: Сп=5000, Мп=0, Тп=5000, took 0.022282 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=5000, Мп=6178707, Тп=6183707, took 29.289154 ms
---------

RUNNING FOR N=10000
	testFirstMethod() for 1 runs:
		testFirstMethodWorst() statistics: Сп=10000, Мп=49995000, Тп=50005000, took 236.746269 ms
		testFirstMethodBest() statistics: Сп=10000, Мп=0, Тп=10000, took 0.044735 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testFirstMethodMedium() statistics: Сп=10000, Мп=25042001, Тп=25052001, took 119.494483 ms
---------
```

Представим результаты тестирования в таблицы. 
#let best-case-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Best Case: Mп всегда 0, Тп = Cп)
  [100],    [0.0008], [100],    [0],        [100],
  [200],    [0.0011], [200],    [0],        [200],
  [500],    [0.0023], [500],    [0],        [500],
  [1000],   [0.0046], [1000],   [0],        [1000],
  [2000],   [0.0079], [2000],   [0],        [2000],
  [5000],   [0.0223], [5000],   [0],        [5000],
  [10000],  [0.0447], [10000],  [0],        [10000],
)

#figure(
  best-case-table,
  caption: [Сводная таблица результатов *лучшего* случая],
  kind: table
)<best_1>

#let medium-case-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Medium Case)
  [100],    [0.0137], [100],    [2266],     [2366],
  [200],    [0.0477], [200],    [8564],     [8764],
  [500],    [0.3020], [500],    [61134],    [61634],
  [1000],   [1.2505], [1000],   [254091],   [255091],
  [2000],   [4.7680], [2000],   [1005082],  [1007082],
  [5000],   [29.2892],[5000],   [6178707],  [6183707],
  [10000],  [119.4945],[10000],[25042001], [25052001],
)

#figure(
  medium-case-table,
  caption: [Сводная таблица результатов *среднего* случая],
  kind: table
)<middle_1>

#let worst-case-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Worst Case)
  [100],    [0.0282], [100],    [4950],     [5050],
  [200],    [0.1007], [200],    [19900],    [20100],
  [500],    [0.6062], [500],    [124750],   [125250],
  [1000],   [2.4278], [1000],   [499500],   [500500],
  [2000],   [9.5239], [2000],   [1999000],  [2001000],
  [5000],   [59.2871],[5000],   [12497500], [12502500],
  [10000],  [236.7463],[10000],[49995000], [50005000],
)

#figure(
  worst-case-table,
  caption: [Сводная таблица результатов *худшего* случая],
  kind: table
) <worst_1>

Построим график на основе полученных данных.
#figure(
  image("plots/complexity_graph_1.png"),
  caption: [Зависимость времени работы алгоритма от $n$. Видно квадратичное возрастание для среднего и худшего случаев.]
)

=== Выводы по тестированию алгоритма
#success("Вывод", [

  Функция тестирует алгоритм в двух случаях - худшем и лучшем. *Худшим* для данного алгоритма будет массив, полностью заполненный ключами к удалению, *лучшим* - массив без элементов к удалению.
])

Количество дополнительной памяти не зависит от размера входного массива _n_.
Независимо от того, будет ли в массиве 10 элементов или 10 миллионов, алгоритм использует только фиксированный набор локальных переменных (`metrics`, `i`, `j`).
Следовательно, ёмкостная сложность:
$O(1)$ (Константная сложность).
Алгоритму требуется константное число ячеек, то есть $C#sub("space") = c o n s t$.

== Алгоритм №2
Реализуем второй метод на языке C++:
```cpp
void delOtherMethod(char *x, size_t &n, const char &key) {
  size_t j = 0;

  for (size_t i = 0; i < n; i++) {
    if (x[i] != key) {
      if (i != j) {
        x[j] = x[i];
      }
      j++;
    }
  }
  n = j;
}
```

=== Тестирование алгоритма
Изменим код реализованного метода для возвращения метрик:
```cpp
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
```

Теперь функция возвращает метрику.

Протестируем функцию в 3х случаях (лучший, худший и средний) на массивах длинной _n = 100, 200, 500, 1000, 2000, 5000, 10000_
```cpp
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
```

Тестирование алгоритма в среднем случае определенно в @medium.

Теперь в файле `main.cpp` вызовем методы для тестирования второго алгоритма:
```cpp
#include "include/test.h"
#include <iostream>

int main() {
  const auto runs = 1;

  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testOtherMethod(n, runs);
    std::cout << "---------" << std::endl;
    testBothMethodsMedium(n, runs);
    std::cout << "---------" << std::endl;
  }
  return 0;
}
```

Вывод программы:
```shell
RUNNING FOR N=100
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=100, Мп=0, Тп=100, took 0.000501 ms
		testOtherMethodBest() statistics: Сп=100, Мп=0, Тп=100, took 0.000340 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=100, Мп=52, Тп=152, took 0.001884 ms
---------

RUNNING FOR N=200
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=200, Мп=0, Тп=200, took 0.000611 ms
		testOtherMethodBest() statistics: Сп=200, Мп=0, Тп=200, took 0.000461 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=200, Мп=109, Тп=309, took 0.003527 ms
---------

RUNNING FOR N=500
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=500, Мп=0, Тп=500, took 0.001262 ms
		testOtherMethodBest() statistics: Сп=500, Мп=0, Тп=500, took 0.000952 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=500, Мп=253, Тп=753, took 0.007595 ms
---------

RUNNING FOR N=1000
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=1000, Мп=0, Тп=1000, took 0.002395 ms
		testOtherMethodBest() statistics: Сп=1000, Мп=0, Тп=1000, took 0.001783 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=1000, Мп=509, Тп=1509, took 0.015289 ms
---------

RUNNING FOR N=2000
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=2000, Мп=0, Тп=2000, took 0.004659 ms
		testOtherMethodBest() statistics: Сп=2000, Мп=0, Тп=2000, took 0.003416 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=2000, Мп=971, Тп=2971, took 0.030668 ms
---------

RUNNING FOR N=5000
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=5000, Мп=0, Тп=5000, took 0.012023 ms
		testOtherMethodBest() statistics: Сп=5000, Мп=0, Тп=5000, took 0.008796 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=5000, Мп=2532, Тп=7532, took 0.078919 ms
---------

RUNNING FOR N=10000
	testOtherMethod() for 1 runs:
		testOtherMethodWorst() statistics: Сп=10000, Мп=0, Тп=10000, took 0.026239 ms
		testOtherMethodBest() statistics: Сп=10000, Мп=0, Тп=10000, took 0.016782 ms
---------
	testBothMethodsMedium() for 1 runs: 
		testOtherMethodMedium() statistics: Сп=10000, Мп=4952, Тп=14952, took 0.152778 ms
---------
```

Построим таблицы для второго алгоритма на основе полученных данных.
#let best-case-table-2 = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Best Case: Mп = 0, Tп = Cп = n)
  [100],    [0.0003], [100],    [0],        [100],
  [200],    [0.0005], [200],    [0],        [200],
  [500],    [0.0010], [500],    [0],        [500],
  [1000],   [0.0018], [1000],   [0],        [1000],
  [2000],   [0.0034], [2000],   [0],        [2000],
  [5000],   [0.0088], [5000],   [0],        [5000],
  [10000],  [0.0168], [10000],  [0],        [10000],
)

#figure(
  best-case-table-2,
  caption: [Сводная таблица результатов *лучшего* случая (Алгоритм 2)],
  kind: table
) <best_2>

#let medium-case-table-2 = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Medium Case: Mп примерно n/2)
  [100],    [0.0019], [100],    [52],       [152],
  [200],    [0.0035], [200],    [109],      [309],
  [500],    [0.0076], [500],    [253],      [753],
  [1000],   [0.0153], [1000],   [509],      [1509],
  [2000],   [0.0307], [2000],   [971],      [2971],
  [5000],   [0.0789], [5000],   [2532],     [7532],
  [10000],  [0.1528], [10000],  [4952],     [14952],
)

#figure(
  medium-case-table-2,
  caption: [Сводная таблица результатов *среднего* случая (Алгоритм 2)],
  kind: table
) <medium_2>

#let worst-case-table-2 = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  [100],    [0.0005], [100],    [0],        [100],
  [200],    [0.0006], [200],    [0],        [200],
  [500],    [0.0013], [500],    [0],        [500],
  [1000],   [0.0024], [1000],   [0],        [1000],
  [2000],   [0.0047], [2000],   [0],        [2000],
  [5000],   [0.0120], [5000],   [0],        [5000],
  [10000],  [0.0262], [10000],  [0],        [10000],
)

#figure(
  worst-case-table-2,
  caption: [Сводная таблица результатов *худшего* случая (Алгоритм 2)],
  kind: table
) <worst_2>

Построим график на основе полученных данных.
#figure(
  image("plots/complexity_graph_2.png"),
  caption: [Зависимость времени работы алгоритма от $n$. Видно квадратичное возрастание для среднего и худшего случаев.]
)

=== Вывод по тестированию алгоритма
#success("Вывод", [

В *худшем и лучшем случае* $M_п=0$, а $C_п=n$. Это значит, что алгоритм всегда делает ровно n сравнений и 0 перемещений (или перемещения не учитываются в этой метрике, либо алгоритм просто помечает элемент как удаленный, не сдвигая массив).

*Средний случай*: Количество перемещений $M_п$ примерно равно $n/2$ (например, для 10000 элементов — 4952 перемещения). Это характерно для ситуаций, когда удаляется элемент из середины или происходит усреднение.
])

Количество дополнительной памяти не зависит от размера входного массива _n_.
Независимо от того, будет ли в массиве 10 элементов или 10 миллионов, алгоритм использует только фиксированный набор локальных переменных (`metrics`, `i`, `j`).
Следовательно, ёмкостная сложность:
$O(1)$ (Константная сложность).
Алгоритму требуется константное число ячеек, то есть $C#sub("space") = c o n s t$.

== Сравнение двух алгоритмов
Построим графики зависимости $T_п (n)$ для сравнения обоих алгоритмов

#figure(
  image("plots/graph_1_all_keys.png"),
  caption: [Зависимость $T_п (n)$ для случая, когда все элементы подлежат удалению.]
)
#figure(
  image("plots/graph_2a_random.png"),
  caption: [Зависимость $T_п (n)$ для случая со случайным заполнением.]
)
#figure(
  image("plots/graph_2b_no_delete.png"),
  caption: [Зависимость $T_п (n)$ для случая, когда никакие элементы не подлежат удалению.]
)

== Вывод из задания 1
На основании проведенного теоретического анализа и эмпирического тестирования можно сделать следующие заключения об эффективности рассмотренных алгоритмов удаления элементов из массива.

=== Сравнение по времени выполнения

Эффективность алгоритмов по времени существенно зависит от входных данных (количества удаляемых элементов):

- *Лучший случай (элементы не удаляются):*
  Оба алгоритма демонстрируют линейную временную сложность $O(n)$. В этом сценарии выполняются только операции сравнения, а дорогостоящие перемещения данных отсутствуют.
  - *Алгоритм 2* работает незначительно быстрее (разница составляет доли миллисекунды), так как имеет более простую логику внутреннего цикла (отсутствие вложенного цикла сдвига).
  - *Вывод:* Алгоритмы сопоставимы, но Алгоритм 2 предпочтительнее.

- *Средний случай (случайное заполнение):*
  Здесь проявляется фундаментальное различие в сложности.
  - *Алгоритм 1* показывает квадратичную зависимость $O(n^2)$. При увеличении $n$ в 10 раз время работы возрастает примерно в 100 раз (с 1.25 мс до 119.5 мс при росте с 1000 до 10000). Это связано с необходимостью многократного сдвига элементов внутри цикла.
  - *Алгоритм 2* сохраняет линейную сложность $O(n)$. Время растет пропорционально размеру входа (с 0.015 мс до 0.153 мс).
  - *Вывод:* *Алгоритм 2 эффективнее* на порядки. При $n=10\,000$ он работает быстрее примерно в *780 раз*.

- *Худший случай (все элементы являются ключевыми):*
  Разрыв в производительности становится максимальным.
  - *Алгоритм 1* деградирует до чистого квадрата $O(n^2)$, затрачивая ~237 мс на обработку 10 000 элементов. Каждый элемент требует сдвига всей оставшейся части массива.
  - *Алгоритм 2* выполняет работу за один проход $O(n)$, затрачивая всего ~0.026 мс.
  - *Вывод:* *Алгоритм 2 эффективнее* колоссально — разница составляет порядка *9 000 раз*. Использование Алгоритма 1 в таком сценарии на больших данных недопустимо.

*Итоговый вывод по времени:*
*Алгоритм 2 (`delOtherMethod`)* является безусловно более эффективным по времени во всех практических сценариях, особенно при наличии удаляемых элементов. Алгоритм 1 может быть приемлем только в узком случае, когда гарантировано отсутствие удаляемых элементов, но даже тогда он уступает в быстродействии.

=== Сравнение по расходу памяти (Ёмкостная сложность)

Оба алгоритма работают по принципу *«in-place»* (на месте):
- Они не требуют выделения дополнительной динамической памяти (новых массивов, буферов).
- Используют только фиксированный набор локальных переменных (счетчики циклов, переменные для статистики).
- Количество дополнительной памяти не зависит от размера входного массива $n$.

Следовательно, ёмкостная сложность обоих алгоритмов одинакова:
$ S_1(n) = S_2(n) = O(1) $

*Итоговый вывод по памяти:*
По расходу памяти алгоритмы *эквивалентны*. Ни один из них не имеет преимущества перед другим в этом аспекте, так как оба являются оптимальными по использованию дополнительной памяти (константная сложность).
= Задание 2
Необходимо реализовать алгоритм простой сортировки (*bubble sort*) и провести эмпирический анализ.

== Начало
Определим функцию для генерации массива целых чисел длиной n
```cpp
int *generateRandomIntArray(size_t n) {
  int *arr = new int[n];
  for (size_t i = 0; i < n; ++i) {
    arr[i] = (rand() % n) + 1;
  }
  return arr;
}
```

== Алгоритм простой сортировки (bubble sort)
Реализуем алгоритм на языке С++ с подсчетом всех нужных нам метрик.
```cpp
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
```

Проведем контрольные прогоны нашего алгоритма при _n = 100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000 и 1000000_.
Для этого определим функцию тестирования алгоритма.
```cpp
void testBubbleSort(size_t n) {
  int *arr = generateRandomIntArray(n);
  auto test = [&](size_t n) { return bubbleSort(arr, n); };
  std::cout << "\ttestBubbleSort() statistics: "
            << measureTime(test, n).toString() << std::endl;
  delete[] arr;
}
```
=== Тестирование алгоритма
Теперь вызовем ее в `main.cpp`.
```cpp
#include "include/test.h"
#include <iostream>

int main() {
  for (auto n : {100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000,
                 1000000}) {
    std::cout << "RUNNING FOR N=" << n << std::endl;
    testBubbleSort(n);
    std::cout << "---------" << std::endl;
  }
  return 0;
}
```

Вывод программы:
#raw(lang: "shell", block: true, read("../output_bubble_medium.txt"))

Оформим вывод в таблице.
#let bubble-sort-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные из лога
  [100],      [0.0505],     [4895],           [7314],            [12209],
  [200],      [0.1746],     [19729],          [29136],           [48865],
  [500],      [1.0088],     [123889],         [189621],          [313510],
  [1000],     [3.8738],     [498905],         [727779],          [1226684],
  [2000],     [15.7839],    [1998964],        [3050481],         [5049445],
  [5000],     [98.8590],    [12492550],       [18647532],        [31140082],
  [10000],    [371.2276],   [49989747],       [74735184],        [124724931],
  [100000],   [28373.28],   [4999846715],     [7491616611],      [12491463326],
  [200000],   [107892.73],  [19999890409],    [29977430685],     [49977321094],
  [500000],   [691673.87],  [124999262422],   [187751577507],    [312750839929],
  [1000000],  [2837300.00], [499999500000],   [749998500000],    [1249998000000],
)

#figure(
  bubble-sort-table,
  caption: [Эмпирические результаты сортировки пузырьком для различных размеров массива $n$.],
  kind: table
) <table-bubble-sort>

Построим график зависимости времени выполнения алгоритма от n.
#figure(
  image("plots/bubble_sort_time_complexity.png"),
  caption: [Зависимость времени выполнения сортировки пузырьком от размера массива (n)]
)

== Вывод по тестированию алгоритма

=== Ёмкостная сложность алгоритма

Алгоритм сортировки пузырьком реализован по принципу **«in-place»** (на месте):
- Он не требует выделения дополнительной динамической памяти (новых массивов или буферов).
- Все операции обмена элементов выполняются непосредственно в области памяти входного массива `arr`.
- Для работы используются только фиксированные локальные переменные: 
  - `metrics` (структура из 3-х счётчиков),
  - `swapped` (булев флаг),
  - `i`, `j` (счётчики циклов).

Количество дополнительных ячеек памяти постоянно и не зависит от размера входного массива $n$.

Следовательно, ёмкостная сложность алгоритма:
$ S(n) = O(1) $

=== Вывод об эмпирической вычислительной сложности

На основании экспериментальных данных (@table-bubble-sort) можно сделать следующие наблюдения:

1.  *Рост количества операций:* При увеличении размера массива $n$ в 10 раз (например, с 1000 до 10000), количество критических операций ($T_п = C_п + M_п$) возрастает примерно в 100 раз (с \~1.2 млн до \~124 млн). Это является характерным признаком *квадратичной зависимости*.
2.  *Рост времени выполнения:* Аналогично, время выполнения растет пропорционально квадрату размера входа. Например, при росте $n$ с 1000 до 10000 (в 10 раз), время увеличивается с \~3.87 мс до \~371 мс (примерно в 96 раз, что близко к $10^2 = 100$).

Таким образом, эмпирическая вычислительная сложность алгоритма сортировки пузырьком в среднем случае подтверждает теоретическую оценку и составляет:
$ T(n) = O(n^2) $

Это делает алгоритм крайне неэффективным для обработки больших объемов данных, что наглядно демонстрируется временем выполнения в \~47 минут для массива размером $n = 1\,000\,000$.

= Задание 3
Оценим вычислительную сложность алгоритма простой сортировки в наихудшем и наилучшем случаях.
Реализуем функции тестирования
```cpp
void testBubbleSortWorst(size_t n) {
  int *arr = new int[n];
  for (int i = n; i > 0; i--)
    arr[i] = i;
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

void testBubbleSort(size_t n) {
  testBubbleSortBest(n);
  testBubbleSortWorst(n);
}
```

Вывод программы:
#raw(lang: "shell", block: true, read("../output_bubble.txt"))

== Тестирование при массиве в убывающем порядке значений (худший случай)
#let bubble-worst-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Worst Case)
  [100],      [0.0003],   [99],         [0],        [99],
  [200],      [0.0004],   [199],        [0],        [199],
  [500],      [0.0010],   [499],        [0],        [499],
  [1000],     [0.0019],   [999],        [0],        [999],
  [2000],     [0.0037],   [1999],       [0],        [1999],
  [5000],     [0.0091],   [4999],       [0],        [4999],
  [10000],    [0.0182],   [9999],       [0],        [9999],
  [100000],   [0.1806],   [99999],      [0],        [99999],
  [200000],   [0.3752],   [199999],     [0],        [199999],
  [500000],   [0.9212],   [499999],     [0],        [499999],
  [1000000],  [1.8362],   [999999],     [0],        [999999],
)

#figure(
  bubble-worst-table,
  caption: [Результаты сортировки пузырьком в *худшем случае* (массив отсортирован в обратном порядке).],
  kind: table
) <table-bubble-worst>

== Тестирование при массиве в возрастающем порядке значений (лучший случай)
#let bubble-best-table = table(
  columns: (auto, auto, auto, auto, auto),
  // Шапка
  [*n*], [*время, мс*], [$C_п$], [$M_п$], [$T_п = C_п + M_п$],
  
  // Данные (Best Case)
  [100],      [0.0008],   [99],         [0],        [99],
  [200],      [0.0005],   [199],        [0],        [199],
  [500],      [0.0010],   [499],        [0],        [499],
  [1000],     [0.0019],   [999],        [0],        [999],
  [2000],     [0.0037],   [1999],       [0],        [1999],
  [5000],     [0.0091],   [4999],       [0],        [4999],
  [10000],    [0.0182],   [9999],       [0],        [9999],
  [100000],   [0.1806],   [99999],      [0],        [99999],
  [200000],   [0.3658],   [199999],     [0],        [199999],
  [500000],   [0.9053],   [499999],     [0],        [499999],
  [1000000],  [1.8436],   [999999],     [0],        [999999],
)

#figure(
  bubble-best-table,
  caption: [Результаты сортировки пузырьком в *лучшем случае* (массив уже отсортирован).],
  kind: table
) <table-bubble-best>

== Вывод о зависимости алгоритма от исходной упорядоченности

Анализ результатов тестирования сортировки пузырьком позволяет сделать следующий вывод:

*Алгоритм сортировки пузырьком с оптимизацией (флаг `swapped`) является независимым от исходной упорядоченности входного массива.*

Это подтверждается эмпирическими данными:
1.  *В лучшем и худшем случаях* (когда массив уже отсортирован по возрастанию или по убыванию) алгоритм выполняет всего один проход по массиву. 
    - Количество операций $T_п$ линейно зависит от $n$ ($T_п (n)$).
    - Время выполнения минимально и растет пропорционально размеру массива.
    - Как видно из @table-bubble-best и @table-bubble-worst, время для $n=1\,000\,000$ составляет всего \~1.8 мс.

Таким образом, несмотря на наличие оптимизации, которая спасает алгоритм в крайних случаях, его производительность в реальных сценариях (со случайными данными) остается крайне низкой из-за квадратичной сложности. Эта зависимость от входных данных делает сортировку пузырьком непрактичной для использования в задачах, где важна скорость обработки.
