import matplotlib.pyplot as plt

# Данные для сортировки пузырьком
n = [100, 200, 500, 1000, 2000, 5000, 10000, 100000, 200000, 500000, 1000000]
time_ms = [
    0.050515,     # N=100
    0.174568,     # N=200
    1.008826,     # N=500
    3.873780,     # N=1000
    15.783902,    # N=2000
    98.859014,    # N=5000
    371.227632,   # N=10000
    28373.277437, # N=100000
    107892.730332,# N=200000
    691673.869456,# N=500000
    2837300.000000# N=1000000
]

plt.figure(figsize=(12, 8))

plt.plot(n, time_ms, label='Сортировка пузырьком', color='purple', marker='o', linewidth=2)

# Настройки
plt.title('Зависимость времени выполнения сортировки пузырьком от размера массива (n)', fontsize=14, fontweight='bold')
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)
plt.grid(True, which='both', linestyle='--', alpha=0.7)
plt.legend()

# Сохранение
plt.savefig('./docs/plots/bubble_sort_time_complexity.png', dpi=300, bbox_inches='tight')
print("✅ График сохранен как 'bubble_sort_time_complexity.png'")
