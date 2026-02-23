import matplotlib.pyplot as plt

n = [100, 200, 500, 1000, 2000, 5000, 10000]

best =   [0.000340, 0.000461, 0.000952, 0.001783, 0.003416, 0.008796, 0.016782]
medium = [0.001884, 0.003527, 0.007595, 0.015289, 0.030668, 0.078919, 0.152778]
worst =  [0.000501, 0.000611, 0.001262, 0.002395, 0.004659, 0.012023, 0.026239]

plt.figure(figsize=(10, 6))

plt.plot(n, best, label='Лучший случай (Best)', color='green', marker='o', linewidth=2)
plt.plot(n, medium, label='Средний случай (Average)', color='orange', marker='s', linewidth=2)
plt.plot(n, worst, label='Худший случай (Worst)', color='red', marker='^', linewidth=2)

plt.title('Алгоритм 2: Зависимость времени выполнения от n', fontsize=14, fontweight='bold')
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)

plt.grid(True, which='both', linestyle='--', alpha=0.7)

plt.legend()

output_file = 'complexity_graph_2.png'
plt.savefig(output_file, dpi=300, bbox_inches='tight')
