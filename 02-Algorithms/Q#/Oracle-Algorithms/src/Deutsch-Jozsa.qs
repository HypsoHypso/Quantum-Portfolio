operation ConstOracle(qs: Qubit[]) : Unit {
    // TODO
    // => Nothing to do for constant oracle
}

operation BalancedOracle(qs: Qubit[]) : Unit {
    // TODO
    use aux = Qubit();
    X(aux);
    H(aux);
    for i in 0..Length(qs)-1 {
        CNOT(qs[i], aux);
    }
    Reset(aux);
}

operation ConstantDeutschJosza(): Result[] {
    // TODO
    use qs = Qubit[3];
    ApplyToEach(H, qs);
    ConstOracle(qs);
    ApplyToEach(H, qs);

    return MResetEachZ(qs);
}

operation BalancedDeutschJosza(): Result[] {
    // TODO
    use qs = Qubit[3];
    ApplyToEach(H, qs);
    BalancedOracle(qs);
    ApplyToEach(H, qs);

    return MResetEachZ(qs);
}
