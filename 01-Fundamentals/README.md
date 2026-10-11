# 01 - Fundamentals

Foundational quantum computing circuits, implemented with Qiskit.

## Contents

| File | Description |
|------|-------------|
| `Teleportation.ipynb` | Quantum teleportation of a single-qubit state, with a built-in correctness check |

## Teleportation

### Goal
Transfer the unknown state of one qubit (Alice's) to another qubit (Bob's) using one shared Bell pair and two classical bits. The state itself is never sent through a channel.

### Circuit (3 qubits, 3 classical bits)

| Step | Operation | Purpose |
|------|-----------|---------|
| 0 | `H`, `S` on $q_0$ | Alice prepares $\|\phi\rangle = S H \|0\rangle = \frac{\|0\rangle + i\|1\rangle}{\sqrt{2}}$ |
| 1 | `H`($q_1$), `CX`($q_1$, $q_2$) | Create the shared Bell pair between Alice ($q_1$) and Bob ($q_2$) |
| 2-3 | `CX`($q_0$, $q_1$), `H`($q_0$) | Alice's Bell-basis rotation |
| 4 | Measure $q_0 \to c_0$, $q_1 \to c_1$ | Alice obtains two random classical bits $(m_0, m_1)$ |
| 5 | `CX`($q_1$, $q_2$), `CZ`($q_0$, $q_2$) | Bob applies the correction $Z^{m_0} X^{m_1}$ |
| 6 | $S^3$, `H` on $q_2$, measure $q_2 \to c_2$ | Verification (see below) |

### Verification
If Bob's qubit is exactly $|\phi\rangle$, applying the inverse of Alice's preparation must bring it back to $|0\rangle$.

- Preparation: $U = S H$
- Inverse: $U^{-1} = H^{\dagger} S^{\dagger} = H S^3$, because $S^4 = I$
- Gates are applied in reverse order: first $S^3$, then $H$

Expected result: $c_2 = 0$ with probability 1. In general, $P(0) = |\langle \phi | \psi \rangle|^2$ where $|\psi\rangle$ is Bob's actual state.

### Results
Over 8192 shots on `BasicSimulator`, $c_2$ is always `0`. The bits $c_0$ and $c_1$ are uniformly distributed (about 25% each), as expected for a Bell measurement.

