import matplotlib.pyplot as plt

# Данные
n = [100, 200, 500, 1000, 2000, 5000, 10000]
best = [0.0008, 0.0011, 0.0023, 0.0046, 0.0079, 0.0223, 0.0447]
medium = [0.0137, 0.0477, 0.3020, 1.2505, 4.7680, 29.2892, 119.4945]
worst = [0.0282, 0.1007, 0.6062, 2.4278, 9.5239, 59.2871, 236.7463]

plt.figure(figsize=(10, 6))

# Построение линий
plt.plot(n, best, label='Лучший случай (Best)', color='green', marker='o', linewidth=2)
plt.plot(n, medium, label='Средний случай (Average)', color='orange', marker='s', linewidth=2)
plt.plot(n, worst, label='Худший случай (Worst)', color='red', marker='^', linewidth=2)

# Настройки
plt.title('Зависимость времени выполнения от размера входных данных (n)', fontsize=14)
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)
plt.grid(True, which='both', linestyle='--', alpha=0.7)
plt.legend()

# Сохранение
plt.savefig('complexity_graph_1.png', dpi=300, bbox_inches='tight')
