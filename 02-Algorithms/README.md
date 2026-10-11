
## Q# projects

Each Q# folder is a standalone project with its own `qsharp.json`.

### Grover (`Q#/Grover`)
| File | Role |
|------|------|
| `src/SingleGrover.qs` | Grover search for one marked item, including the diffusion operator |
| `src/MultipleGrover.qs` | Grover search for several marked items |
| `src/benchmark.py` | Benchmark script (Python host) |

- The phase oracle for multiple secrets is built with `ApplyControlledOnBitString` on an auxiliary qubit in the $|-\rangle$ state.
- The number of iterations is $r=\mathrm{round}\left(\frac{\pi}{4}\sqrt{N/M}\right)$ with $N=2^n$ items and $M$ marked items.

### Oracle algorithms (`Q#/Oracle-Algorithms`)
`Deutsch-Jozsa.qs`, `Bernstein-Vazirani.qs` and the shared `Oracle.qs`. Both algorithms decide a property of a hidden function with a single oracle query.

### QFT and QPE (`Q#/QFT-QPE`)
`QFT.qs`, `QPE.qs` and `QPEPlus.qs`. These are the building blocks reused by Shor's algorithm.

### Shor (`Q#/Shor`)
| File | Role |
|------|------|
| `src/ClassicalPart.qs` | Classical pre- and post-processing |
| `src/PhaseEstimation.qs` | Quantum phase estimation of the modular multiplication |
| `src/UGate.qs` | Reversible arithmetic: `AddConstantModulo` and `MultiplyConstantModulo` ($|x\rangle\mapsto|cx \bmod N\rangle$), controlled and adjoint |
| `src/benchmark.qs`, `src/benchmark.ipynb` | Resource and performance benchmark (plot: `benchmark_applyugate.png`) |

`UGate.qs` includes unit tests (multiplication, identity, Fermat's little theorem, inverse, adjoint on a superposition). The register must hold a value strictly smaller than the modulus, otherwise the operation fails.

## Qiskit notebooks

| Notebook | Content |
|----------|---------|
| `Qiskit/Grover/Grover.ipynb` | Grover search on 2 and 3 qubits, success probability versus number of iterations, compared with theory |
| `Qiskit/HHL/HHL_implementation_presentation.ipynb` | HHL for 2x2 Hermitian systems: QPE, eigenvalue inversion, inverse QPE, post-selection on the ancilla |

## Running the code

**Q#**: open a project folder in VS Code with the Q# extension, or from Python: