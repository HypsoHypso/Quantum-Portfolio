# 04 - Optimization

Quantum approaches to combinatorial optimization, implemented with Qiskit.

## Contents

| File | Description |
|------|-------------|
| `QAOA.ipynb` | QAOA applied to MaxCut on a 5-vertex graph, validated against brute force |

## QAOA for MaxCut

### Problem
Partition the vertices of a graph into two sets so that the number of edges crossing the partition is maximal. The graph has 5 vertices and 6 edges: (0,1), (0,2), (1,2), (1,3), (2,4), (3,4).

### Encoding
Each vertex $i$ is a qubit, and its value $z_i=\pm 1$ gives its side of the cut. The cost Hamiltonian is

$$H_c=\sum_{(i,j)\in E} Z_iZ_j$$

Minimizing $\langle H_c\rangle$ maximizes the cut. Each cut edge contributes $-1$ and each uncut edge $+1$, so a cut of size $k$ has energy $-k+(6-k)$.

### Ground truth (brute force)
The triangle (0,1,2) can have at most 2 cut edges, so the maximum cut is 5 and the minimum energy is $-4$. Exactly four bitstrings reach it: `01100`, `01101`, `10010`, `10011` (read right to left, $q_0$ on the right). They come in complementary pairs because $H_c$ is invariant under flipping all bits.

### Circuit
A QAOA layer of depth $p$ alternates a cost layer and a mixer layer:

$$|\psi(\boldsymbol\beta,\boldsymbol\gamma)\rangle=\prod_{k=1}^{p} e^{-i\beta_k H_m}\,e^{-i\gamma_k H_c}\,H^{\otimes n}|0\rangle^{\otimes n},\qquad H_m=\sum_i X_i$$

| Layer | Gates | Role |
|-------|-------|------|
| Initialization | $H$ on every qubit | Uniform superposition over all cuts |
| Cost | $RZZ(2\gamma_k)$ on each edge | Phase each cut according to its energy |
| Mixer | $R_x(2\beta_k)$ on every qubit | Move amplitude between neighboring cuts |

The cost gate comes from $e^{-i\gamma Z_iZ_j}=\mathrm{CNOT}\,(I\otimes R_z(2\gamma))\,\mathrm{CNOT}$ (derived in the notebook). The ansatz is built with `QAOAAnsatz(H_c, reps=2)`. Its parameter order is $[\beta_0,\beta_1,\gamma_0,\gamma_1]$.

### Hybrid loop
1. Evaluate $\langle H_c\rangle$ on the ansatz with `StatevectorEstimator` (exact, no shot noise).
2. Update the 4 parameters with COBYLA.
3. Repeat from several random starting points, since the landscape has local minima.
4. Sample the best parameters with `StatevectorSampler` and read off the most frequent bitstrings.

### Results ($p=2$)
- The optimizer reaches a best energy of about $-3.25$, against an exact minimum of $-4$. With $p=2$ the circuit cannot reach $-4$: about 70% of the probability mass lies on the four optimal cuts.
- The four most frequent sampled bitstrings are exactly the four brute-force solutions.
- The final energy depends on the starting point. Across random restarts, the results spread from about $-0.9$ to about $-3.2$.

### Weighted MaxCut
With edge weights $w_{ij}$, the cost becomes $C=\sum w_{ij}\frac{1-z_iz_j}{2}$ and the Hamiltonian becomes $H_c=\sum w_{ij}Z_iZ_j$. Only the cost layer changes: each gate becomes $RZZ(2\gamma w_{ij})$. The qubit count, the initialization and the mixer stay the same.

### Limitations
- Simulation only (statevector), no hardware noise.
- Small graph and shallow depth ($p=2$), so the approximation is not tight.