// # Sample
// Getting started
//
// # Description
// This is a minimal Q# program that can be used to start writing Q# code.

// This function runs grover with a secret, a number of qubits and a number of iterations
operation Grover(secret: Int, nbQubits: Int, nbIterations: Int): Result[] {
    // TODO
    use qs = Qubit[nbQubits];

    ApplyToEachA(H, qs);
    for i in 1..nbIterations {
        GenerateGroverPhaseOracle(secret)(qs);
        GroverDiffusionOperator(qs);
    }
    return MResetEachZ(qs);
}

import Std.Arrays.Most;
import Std.Arrays.Tail;

// This function implements the Grover Diffusion Operator
operation GroverDiffusionOperator(qs: Qubit[]): Unit {
    // TODO
    within {
        ApplyToEachA(H, qs);
        ApplyToEachA(X, qs);
    } apply {
        Controlled Z(Most(qs), Tail(qs));
    }
}

// This function generates the Grover Phase Oracle for a single secret
function GenerateGroverPhaseOracle(secret: Int): (Qubit[] => Unit) {
    // TODO
    return (qs) => {
        use aux = Qubit();
        within {
            X(aux);
            H(aux);
        } apply {
            ApplyControlledOnInt(secret, X, qs, aux);
        }
    };
}

// This function is useless but gives the syntax needed for the function above
function smallHelp(): (Qubit[] => Unit) {
    return (qs) => {
        Message("Do stuff")
    }
}

// import Std.Diagnostics.DumpMachine;

// @EntryPoint()
// operation Main() : Unit {
//     // 1. Allocate qubits
//     use qs = Qubit[3];
//     // 2. Put them in some interesting state
//     ApplyToEach(H, qs);
//     // 3. Call the operation you want to test
//     //GenerateGroverPhaseOracle(5)(qs);
//     //GroverDiffusionOperator(qs);
//     for i in 1..100 {
//         let res = Grover(5, 3, 2);
//         Message($"{res}");
//     }

//     // 4. Inspect the quantum state
//     DumpMachine();
//     // 5. Clean up before leaving
//     ResetAll(qs);
// }

// operation histo() : Result[]
// {
//     return Grover(21, 5, 6);
// }