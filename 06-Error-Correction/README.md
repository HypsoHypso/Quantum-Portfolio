# 06 - Error Correction

Small experiments on quantum error correction (QEC), in two toolchains.

```
06-Error-Correction/
├── qiskit-3-qubit-code/
│   └── QEC_3_qubit_code.ipynb
└── qsharp-shor-code/
    ├── qsharp.json
    └── src/
        ├── SimpleQEC.qs
        └── ShorQEC.qs
```

## `qiskit-3-qubit-code/` (Qiskit)

`QEC_3_qubit_code.ipynb` is a step-by-step walkthrough of the 3-qubit repetition code, in 14 activities:

1. Error detection and correction probabilities (`1 - p^3`, `1 - 3p^2 + 2p^3`) and their plot.
2. The no-cloning theorem and why we encode with CNOTs instead of copying.
3. GHZ-style encoding `a|000> + b|111>`, then injected bit-flip errors.
4. Syndrome extraction with two ancilla qubits (`|00>`: no error, `|11>`: qubit 0, `|10>`: qubit 1, `|01>`: qubit 2) and the correction step.
5. Limits of the code: two simultaneous bit-flips (wrong correction) and phase-flips (undetected), fixed by switching to the Hadamard basis.
6. Logical basis states and the 9-qubit Shor code, with a count of the 8 syndrome bits.

Run it with `pip install qiskit matplotlib jupyter`, then `jupyter lab`.

## `qsharp-shor-code/` (Q#)

A Q# project (`qsharp.json` + `src/`) that encodes, corrupts and decodes a qubit.

- `src/SimpleQEC.qs`: building blocks. `EncodeBitFlip` / `DecodeBitFlip` and `EncodePhaseFlip` / `DecodePhaseFlip` (CNOT fan-out, then a Toffoli-based majority vote on decode), plus `TestBitFlip`, `TestPhaseFlip` and an `@EntryPoint` `Main`. Results are shown with `DumpMachine`.
- `src/ShorQEC.qs`: the 9-qubit Shor code (1 logical + 8 encoded qubits) built from the blocks above. `EncodeShorCode` / `DecodeShorCode` are tested in `TestShor` with no error, an X error, a Z error and a combined X and Z error.

Run it with the Q# VS Code extension, or with `qsharp` from Python.
