# Quantum Computing Portfolio

Hands-on quantum computing notebooks and implementations from my degree course, organized by topic. They cover fundamentals, algorithms, chemistry, optimization, error correction, quantum machine learning, neutral atoms and hardware noise, in Qiskit, Q# and Pulser.

## Contents

| Folder | Topic | Content |
| --- | --- | --- |
| [01-Fundamentals](01-Fundamentals) | Fundamentals | [Quantum teleportation](01-Fundamentals/Teleportation.ipynb) of a single-qubit state, with a built-in correctness check |
| [02-Algorithms](02-Algorithms) | Algorithms | Qiskit: [Grover](02-Algorithms/Qiskit/Grover) and [HHL](02-Algorithms/Qiskit/HHL). Q#: [Grover](02-Algorithms/Q%23/Grover), [oracle algorithms](02-Algorithms/Q%23/Oracle-Algorithms) (Deutsch-Jozsa, Bernstein-Vazirani), [QFT and QPE](02-Algorithms/Q%23/QFT-QPE), [Shor](02-Algorithms/Q%23/Shor) |
| [03-Chemistry](03-Chemistry) | Quantum chemistry | [VQE](03-Chemistry/VQE.ipynb), the variational eigensolver for chemistry problems |
| [04-Optimization](04-Optimization) | Optimization | [QAOA](04-Optimization/QAOA.ipynb) for MaxCut on a 5-vertex graph, validated against brute force |
| [05-Quantum-Machine-Learning](05-Quantum-Machine-Learning) | Quantum machine learning | [QSCV](05-Quantum-Machine-Learning/QSCV.ipynb) (quantum kernel + SVC/QSVC), [VQC](05-Quantum-Machine-Learning/VQC.ipynb) (variational classifier on Iris), [DQC](05-Quantum-Machine-Learning/DQC.ipynb) (differentiable quantum circuits for an ODE) |
| [06-Error-Correction](06-Error-Correction) | Error correction | [Qiskit 3-qubit code](06-Error-Correction/qiskit-3-qubit-code) walkthrough, and a [Q# Shor code](06-Error-Correction/qsharp-shor-code) project |
| [07-Neutral-Atoms](07-Neutral-Atoms) | Neutral atoms | [Rydberg blockade](07-Neutral-Atoms/Rydberg.ipynb) between two atoms, and [graph features](07-Neutral-Atoms/Graph_features.ipynb) to tell two graphs apart |
| [08-Hardware-Noise](08-Hardware-Noise) | Hardware noise | [Coherence](08-Hardware-Noise/Coherence.ipynb) (T1 and T2 estimation with a thermal relaxation model) and [single-qubit tomography](08-Hardware-Noise/Tomography.ipynb) |

Each folder has its own `README.md` with the details of its notebooks.

## Repository Map

```text
01-Fundamentals/                 Teleportation
02-Algorithms/
    Qiskit/                      Grover, HHL
    Q#/                          Grover, Oracle-Algorithms, QFT-QPE, Shor
03-Chemistry/                    VQE
04-Optimization/                 QAOA
05-Quantum-Machine-Learning/     QSCV, VQC, DQC
06-Error-Correction/
    qiskit-3-qubit-code/         3-qubit repetition code
    qsharp-shor-code/            Shor code in Q#
07-Neutral-Atoms/                Rydberg, Graph_features
08-Hardware-Noise/               Coherence, Tomography
```

## Technologies

- Python and Jupyter notebooks
- [Qiskit](https://qiskit.org) with Qiskit Aer and Qiskit Machine Learning
- Q# projects (each with its own `qsharp.json`)
- [Pulser](https://pulser.readthedocs.io) for neutral-atom simulation

## Getting Started

```bash
git clone [https://github.com/HypsoHypso/Quantum-Portfolio.git](https://github.com/HypsoHypso/Quantum-Portfolio.git)
cd Quantum-Portfolio
python -m venv .venv && source .venv/bin/activate
pip install qiskit qiskit-aer qiskit-machine-learning scikit-learn scipy numpy pandas matplotlib seaborn networkx pulser pulser-simulation jupyter
jupyter lab
```

Dependencies vary between notebooks, so check the first cells of each one. For the Q# projects, open the project folder in VS Code with the Q# extension, or run them from Python with the `qsharp` package.