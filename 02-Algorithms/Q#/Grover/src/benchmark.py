import numpy as np
import qsharp
qsharp.init(project_root='.')
from qsharp.code.MultipleGrover import GroverWithIterations
from qsharp.code.MultipleGrover import getNbIterations

secrets = [[True, False, True, False], [True, False, True, True]]
count = 0

nb_iter = 100
for i in range(nb_iter):
    res = GroverWithIterations(secrets, 4, 100)
    if res in secrets:
        count += 1

count /= nb_iter
print(f'Empirical success probability: {nb_iter}')

# Accuracy vs NumberOfIterations

r_opt = getNbIterations(secrets, 4)

res = []
for r in range(0, 2 * r_opt + 1):
    count = 0
    for i in range(100):
        res = GroverWithIterations(secrets, 4, r)
        if res in secrets:
            count += 1
    print(count)
    res.append(count)

import matplotlib.pyplot as plt
plt.plot(np.arange(2*r_opt + 1), np.array(res))