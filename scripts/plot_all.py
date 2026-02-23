import matplotlib.pyplot as plt

# --- ДАННЫЕ ---
n = [100, 200, 500, 1000, 2000, 5000, 10000]

# === АЛГОРИТМ 1 (delFirstMethod) ===
# Best: Ни один элемент не удаляется (ключей нет или они в конце? В логе M=0)
alg1_best =   [0.0008, 0.0011, 0.0023, 0.0046, 0.0079, 0.0223, 0.0447]
# Medium: Случайное заполнение
alg1_medium = [0.0137, 0.0477, 0.3020, 1.2505, 4.7680, 29.2892, 119.4945]
# Worst: Все элементы ключевые (удаляем всё)
alg1_worst =  [0.0282, 0.1007, 0.6062, 2.4278, 9.5239, 59.2871, 236.7463]

# === АЛГОРИТМ 2 (delOtherMethod) ===
# Best: Ни один элемент не удаляется
alg2_best =   [0.0003, 0.0005, 0.0010, 0.0018, 0.0034, 0.0088, 0.0168]
# Medium: Случайное заполнение
alg2_medium = [0.0019, 0.0035, 0.0076, 0.0153, 0.0307, 0.0789, 0.1528]
# Worst: Все элементы ключевые
alg2_worst =  [0.0005, 0.0006, 0.0013, 0.0024, 0.0047, 0.0120, 0.0262]

# Настройка стиля
plt.style.use('seaborn-v0_8-whitegrid') # Или 'default', если нет seaborn

# ==========================================
# ГРАФИК 1: Все элементы ключевые (Worst Case)
# ==========================================
plt.figure(figsize=(10, 6))
plt.plot(n, alg1_worst, label='Алгоритм 1 (Худший)', color='red', marker='^', linewidth=2, linestyle='-')
plt.plot(n, alg2_worst, label='Алгоритм 2 (Худший)', color='darkred', marker='s', linewidth=2, linestyle='--')

plt.title('Сравнение: Все элементы являются ключевыми (Worst Case)', fontsize=14, fontweight='bold')
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)
plt.legend()
plt.grid(True, which='both', linestyle='--', alpha=0.6)

# Аннотация для наглядности (опционально)
plt.annotate('O(n²)', xy=(10000, 236), xytext=(6000, 150),
             arrowprops=dict(facecolor='black', shrink=0.05), fontsize=12, color='red')
plt.annotate('O(n)', xy=(10000, 0.026), xytext=(6000, 50),
             arrowprops=dict(facecolor='black', shrink=0.05), fontsize=12, color='darkred')

plt.savefig('graph_1_all_keys.png', dpi=300, bbox_inches='tight')
print("✅ Сохранен: graph_1_all_keys.png")


# ==========================================
# ГРАФИК 2А: Случайное заполнение (Medium Case)
# ==========================================
plt.figure(figsize=(10, 6))
plt.plot(n, alg1_medium, label='Алгоритм 1 (Средний)', color='orange', marker='s', linewidth=2, linestyle='-')
plt.plot(n, alg2_medium, label='Алгоритм 2 (Средний)', color='darkorange', marker='o', linewidth=2, linestyle='--')

plt.title('Сравнение: Случайное заполнение (Average Case)', fontsize=14, fontweight='bold')
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)
plt.legend()
plt.grid(True, which='both', linestyle='--', alpha=0.6)

plt.annotate('O(n²)', xy=(10000, 119), xytext=(6000, 80),
             arrowprops=dict(facecolor='black', shrink=0.05), fontsize=12, color='orange')

plt.savefig('graph_2a_random.png', dpi=300, bbox_inches='tight')
print("✅ Сохранен: graph_2a_random.png")


# ==========================================
# ГРАФИК 2Б: Ни один элемент не удаляется (Best Case)
# ==========================================
plt.figure(figsize=(10, 6))
plt.plot(n, alg1_best, label='Алгоритм 1 (Лучший)', color='green', marker='o', linewidth=2, linestyle='-')
plt.plot(n, alg2_best, label='Алгоритм 2 (Лучший)', color='darkgreen', marker='^', linewidth=2, linestyle='--')

plt.title('Сравнение: Элементы не удаляются (Best Case)', fontsize=14, fontweight='bold')
plt.xlabel('Размер массива (n)', fontsize=12)
plt.ylabel('Время (мс)', fontsize=12)
plt.legend()
plt.grid(True, which='both', linestyle='--', alpha=0.6)

plt.savefig('graph_2b_no_delete.png', dpi=300, bbox_inches='tight')
print("✅ Сохранен: graph_2b_no_delete.png")

print("\n🎉 Все 3 графика построены успешно!")
