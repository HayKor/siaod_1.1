import matplotlib.pyplot as plt

n = [100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000, 1000000]
bubble_worst = [19800, 79600, 499000, 1998000, 7996000, 49990000, 199980000, 19999800000, 79999600000, 499999000000, 1999998000000]
insertion_worst = [9999, 39999, 249999, 999999, 3999999, 24999999, 99999999, 9999999999, 39999999999, 249999999999, 999999999999]

plt.figure(figsize=(10, 6))
plt.plot(n, bubble_worst, label='Пузырёк (Худший)', color='red', marker='^')
plt.plot(n, insertion_worst, label='Вставка (Худший)', color='blue', marker='s')
# plt.xscale('log')
# plt.yscale('log')
plt.title('Сравнение Tₙ(n) в худшем случае')
plt.xlabel('Размер массива (n)')
plt.ylabel('Количество операций (Tₙ)')
plt.legend()
plt.grid(True, which="both", ls="--")
plt.savefig('./docs/plots/comparison_both_sort_worst.png', dpi=300)

bubble_best = [99, 199, 499, 999, 1999, 4999, 9999, 99999, 199999, 499999, 999999]
insertion_best = [198, 398, 998, 1998, 3998, 9998, 19998, 199998, 399998, 999998, 1999998]

plt.figure(figsize=(10, 6))
plt.plot(n, bubble_best, label='Пузырёк (Лучший)', color='green', marker='o')
plt.plot(n, insertion_best, label='Вставка (Лучший)', color='orange', marker='d')
# plt.xscale('log')
# plt.yscale('log')
plt.title('Сравнение Tₙ(n) в лучшем случае')
plt.xlabel('Размер массива (n)')
plt.ylabel('Количество операций (Tₙ)')
plt.legend()
plt.grid(True, which="both", ls="--")
plt.savefig('./docs/plots/comparison_both_sort_best.png', dpi=300)
