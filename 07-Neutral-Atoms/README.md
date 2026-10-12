# 07 - Neutral Atoms

Two Pulser notebooks that simulate Rydberg-atom registers.

## Files

- `Rydberg.ipynb`: Rydberg blockade between two atoms. It applies a pi pulse to each atom in turn, for interatomic distances from 6.5 to 14 um, and plots the population of `|rr>` over time. At short distances the second atom cannot be excited (blockade). The probability of `|rr>` grows with distance, following the `1/R^6` van der Waals interaction.
- `Graph_features-2.ipynb`: Distinguishing two non-isomorphic graphs with a neutral-atom simulation. Both graphs have 8 vertices, 9 edges and the same degree sequence, so these descriptors cannot tell them apart. The notebook:
  1. builds a pentagon-based and a square-based graph from atom coordinates (edge if distance <= 5.5 um) and checks with `networkx` that they are not isomorphic;
  2. embeds them in Pulser registers and drives them with a global Rydberg pulse (`rydberg_global`);
  3. samples the final state and keeps the distribution of the number of excited atoms;
  4. compares the two distributions with the Jensen-Shannon divergence (JSD) and scans the pulse duration to find the time that separates them best.

## Setup

```bash
pip install pulser pulser-simulation networkx numpy matplotlib jupyter
jupyter lab
```
