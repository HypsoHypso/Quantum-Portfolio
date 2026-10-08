# Quantum Computing Portfolio

A collection of hands-on quantum computing notebooks and implementations, organized by topic. The projects cover quantum fundamentals, algorithms, error correction, quantum machine learning, neutral atoms, and hardware noise.

## Selected Work

| Topic | Project highlights |
| --- | --- |
| Fundamentals | [Bell states](01-fundamentals/MAISSE_BellState.ipynb) and [quantum teleportation](01-fundamentals/MAISSE_teleportation.ipynb) |
| Algorithms | [Grover search with Qiskit](02-algorithms/qiskit/grover/MAISSE_Grover.ipynb), [HHL implementation](02-algorithms/qiskit/hhl/HHL_implementation_presentation.ipynb), and Q# projects for [oracle algorithms](02-algorithms/qsharp/Fundamentals-Oracle), [Grover](02-algorithms/qsharp/Grover), [QFT and phase estimation](02-algorithms/qsharp/QFT-QPE), and [Shor](02-algorithms/qsharp/Shor) |
| Quantum error correction | [Error-detection and correction activities](03-qec/MAISSE_QEC.ipynb), with separate [Qiskit three-qubit](03-qec/qiskit-3-qubit-code) and [Q# Shor-code](03-qec/qsharp-shor-code) implementations |
| Quantum machine learning | [VQC](04-quantum-machine-learning/MAISSE_VQC.ipynb), [DQC](04-quantum-machine-learning/MAISSE_DQC.ipynb), and [QSCV](04-quantum-machine-learning/MAISSE_QSCV.ipynb) notebooks |
| Neutral atoms | [Rydberg interaction simulation](05-neutral-atoms/MAISSE_Rydberg.ipynb) and [graph features](05-neutral-atoms/MAISSE_Graph_features.ipynb) |
| Hardware noise | Notebooks on [coherence](06-hardware-noise/MAISSE_Coherence.ipynb) and [tomography](06-hardware-noise/MAISSE_Tomography.ipynb) |

## Repository Map

```text
01-fundamentals/                 States, entanglement, and teleportation
02-algorithms/
	qiskit/                         Grover and HHL notebooks
	qsharp/                         Oracle algorithms, Grover, QFT/QPE, and Shor
03-qec/                           Error-correction activities and implementations
04-quantum-machine-learning/      VQC, DQC, and QSCV notebooks
05-neutral-atoms/                 Rydberg and graph-feature notebooks
06-hardware-noise/                 Coherence and tomography notebooks
```

## Technologies

- Python notebooks, including Qiskit-based circuit work
- Q# projects for quantum algorithms and error correction
- Pulser-based neutral-atom simulation

## Exploring the Projects

Open a `.ipynb` file in Jupyter or VS Code to read and run a notebook. Dependencies and setup can vary between notebooks; check the first cells before execution. Q# projects include their own `qsharp.json` configuration files.