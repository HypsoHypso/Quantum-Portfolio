# Quantum Machine Learning Notebooks

Three Jupyter notebooks built with Qiskit and Qiskit Machine Learning.

## Files

- `QSCV.ipynb`: Classifies the synthetic `ad_hoc_data` set with a quantum kernel. It builds a ZZ feature map, computes the kernel matrix, and trains a classical SVC and a QSVC on it.
- `VQC.ipynb`: Classifies the Iris dataset with a Variational Quantum Classifier. It compares the VQC (`real_amplitudes` and `efficient_su2` ansatzes, COBYLA optimizer) against a classical SVC baseline.
- `DQC.ipynb`: Solves a differential equation with Differentiable Quantum Circuits. It starts with a classical Chebyshev fit, then trains quantum circuits (Product, Cheb and ChebT feature maps) on an ODE residual loss.

## Setup

```bash
pip install qiskit qiskit-machine-learning qiskit-algorithms scikit-learn numpy scipy pandas matplotlib seaborn jupyter
jupyter lab
```