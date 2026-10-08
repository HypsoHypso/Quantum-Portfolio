// You want to make this function Controllable and adjointable as it's gonna be used in the QFT
import Std.Diagnostics.DumpMachine;
import Std.Convert.IntAsDouble;
import Std.Math.PI;

operation Rk(k: Int, q: Qubit): Unit is Adj + Ctl {
    // TODO
    R1(2.0 * PI() / IntAsDouble(1 <<< k), q);
}

// You want to make this function to be "Adjointable"
operation QFT(qs: Qubit[]): Unit is Adj {
    // TODO
    let n = Length(qs);
    for j in 0..n-1 {
        H(qs[j]);

        for k in 2..n-j {
            Controlled Rk([qs[k+j-1]], (k, qs[j]));
        }

    }

    SwapReverseRegister(qs);
}

@EntryPoint()
operation Main() : Unit {
    // 1. Allocate qubits
    use qs = Qubit[3];
    // 2. Put them in some interesting state
    // ApplyToEach(H, qs);
    X(qs[0]);

    // 3. Call the operation you want to test

    QFT(qs);

    // 4. Inspect the quantum state
    DumpMachine();
    // 5. Clean up before leaving
    ResetAll(qs);
}