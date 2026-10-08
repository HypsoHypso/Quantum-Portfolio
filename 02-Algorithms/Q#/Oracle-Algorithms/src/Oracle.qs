operation MarkingOracle(qs: Qubit[], aux: Qubit) : Unit {
    // TODO
    ApplyControlledOnBitString([true, false, true], X, qs, aux);
}

operation PhaseOracle(qs: Qubit[]) : Unit {
    // TODO
    use aux = Qubit();
    X(aux);
    H(aux);
    MarkingOracle(qs, aux);
    Reset(aux);
}
