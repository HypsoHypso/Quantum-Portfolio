# Qubit Characterization: Coherence and Tomography

Two Qiskit notebooks about measuring and characterizing the state of a qubit.

## Files

- `Coherence.ipynb`: Estimating the relaxation time T1 and the coherence time T2 of a noisy qubit in simulation.
  1. The first part explains how each experiment is designed. For T1, prepare `|1>`, wait, then measure Z. For T2, prepare `|+>`, wait, apply a Hadamard, then measure.
  2. It builds a thermal relaxation noise model with `qiskit-aer` for 6 qubits (T1 between 83 and 146 us, T2 between 34 and 56 us, 100 ns per gate), applied to the `id` and `measure` instructions.
  3. It runs the T1 and T2 experiments for delays from 0 to 595 us, with 1024 shots per point.
  4. It fits an exponential `A*exp(-t/T) + B` with `scipy.optimize.curve_fit` and plots the data and the fit for each of the 6 qubits.
  5. It checks that the fitted values are close to the values given to the noise model, and shows that P(0) in the T2 experiment tends to 1/2 as the qubit becomes a mixed state.
- `Tomography-2.ipynb`: Single-qubit state tomography. The function `converter(alpha, beta, shots)` prepares the state `alpha|0> + beta|1>`, measures it in the X, Y and Z bases (Hadamard, S-dagger + Hadamard, and no rotation), and returns the Bloch vector `[<X>, <Y>, <Z>]` estimated from the counts. The example prepares `(|0> + i|1>)/sqrt(2)` and plots the vector with `plot_bloch_vector`; it points along +Y as expected.

## Setup

```bash
pip install qiskit qiskit-aer scipy numpy matplotlib jupyter
jupyter lab
```