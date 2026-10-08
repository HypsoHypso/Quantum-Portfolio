// # Sample
// Getting started
//
// # Description
// This is a minimal Q# program that can be used to start writing Q# code.

import Std.Convert.IntAsDouble;
import SingleGrover.GroverDiffusionOperator;
import Std.Math;
import Std.Convert;

// This functions runs the Grover Algorithm and finds by itself the best number of iterations
operation Grover(secrets: Bool[][], nbQubits: Int): Result[] {
    // TODO
    let nbIterations = getNbIterations(secrets, nbQubits);

    return GroverWithIterations(secrets, nbQubits, nbIterations);
}

// This function runs the Grover Algorithm with a give number of iterations
operation GroverWithIterations(secrets: Bool[][], nbQubits: Int, nbIterations: Int): Result[] {
    // TODO
    use qs = Qubit[nbQubits];
    ApplyToEach(H, qs);
 
    let U = GenerateGroverPhaseOracle(secrets);

    for i in 1..nbIterations {
        U(qs);
        GroverDiffusionOperator(qs);
    }

    return MResetEachZ(qs);
}

// This function computes the best number of iterations
function getNbIterations(secrets: Bool[][], nbQubits: Int): Int {
    // TODO
    return Math.Round((Math.PI() / 4.0) * Math.Sqrt(IntAsDouble((1 <<< nbQubits) / Length(secrets))));
}

// This functions returns a function which is the Grover Phase oracle for multiple secrets
function GenerateGroverPhaseOracle(secrets: Bool[][]): (Qubit[] => Unit) {
    // TODO
    return (qs) => {
        use aux = Qubit();
        within {
            X(aux);
            H(aux);
        } apply {
            for i in 0..Length(secrets)-1 {
                ApplyControlledOnBitString(secrets[i], X, qs, aux);
            }
        }
    };
}

// import Std.Diagnostics.DumpMachine;

// @EntryPoint()
// operation Main() : Unit {
//     // 1. Allocate qubits
//     use qs = Qubit[3];
//     // 2. Put them in some interesting state
//     ApplyToEach(H, qs);
//     // 3. Call the operation you want to test
    
//     let secrets = [[true, false, true], [false, true, false]];

//     GenerateGroverPhaseOracle(secrets)(qs);
    
//     // let iter = getNbIterations([[true]], 10);
//     // Message($"{iter}");

//     // for _ in 1..100 {
//     //     let res = Grover(secrets, 3);
//     //     Message($"{res}");
//     // }

//     // 4. Inspect the quantum state
//     DumpMachine();
//     // 5. Clean up before leaving
//     ResetAll(qs);
// }

// operation histo() : Result[]
// {
//     let secrets = [[true, false, true, false], [false, true, false, false], [false, true, false, true]];
//     return Grover(secrets, 4);
// }