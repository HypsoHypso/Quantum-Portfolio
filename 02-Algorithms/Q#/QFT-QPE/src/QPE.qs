// This is not really mandatory, but it might be useful to make U to the power of something...
// This function should also be made controllable
import Std.Diagnostics.Fact;
import Std.Diagnostics.DumpMachine;
import QFT.QFT;

operation GateToPower(gate: (Qubit) => Unit is Ctl, power: Int, q: Qubit): Unit is Ctl {
    // TODO
    for i in 1..power {
        gate(q);
    }
}

operation QPE(gate: (Qubit) => Unit is Ctl, q: Qubit, nbAncilla: Int): Result[] {
    // TODO
    use ancillas = Qubit[nbAncilla];

    ApplyToEach(H, ancillas);
    for i in 0..nbAncilla-1 {
        Controlled GateToPower([ancillas[nbAncilla - i - 1]], (gate, (1 <<< i), q));
    }

    Adjoint QFT(ancillas);

    return MResetEachZ(ancillas);
}

operation Test_Z() : Result[] {
    use q = Qubit();
    X(q);
    let res = QPE(Z, q, 4);
    X(q);
    return res;
}

operation Test_X() : Result[] {
    use q = Qubit();
    H(q);
    let res = QPE(X, q, 4);
    H(q);
    return res;
}

operation Test_S() : Result[] {
    use q = Qubit();
    X(q);
    let res = QPE(S, q, 4);
    X(q);
    return res;
}


operation Test_T() : Result[] {
    use q = Qubit();
    X(q);
    let res = QPE(T, q, 4);
    X(q);
    return res;
}

operation Test_Y() : Result[] {
    use q = Qubit();
    H(q);
    S(q);
    let res = QPE(Y, q, 4);
    Adjoint S(q);
    H(q);
    return res;
}
