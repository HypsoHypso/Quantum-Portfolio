import Std.Diagnostics.DumpMachine;
import Std.Diagnostics.Fact;

operation EncodeBitFlip(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit is Adj {
    Fact(
        Length(encodedQubits) == 2,
        "There should be only 2 encoded Qubits"
    );
    // TODO
    CNOT(logicalQubit, encodedQubits[0]);
    CNOT(logicalQubit, encodedQubits[1]);
}

operation DecodeBitFlip(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit is Adj {
    Fact(
        Length(encodedQubits) == 2,
        "There should be only 2 encoded Qubits"
    );
    // TODO
    CNOT(logicalQubit, encodedQubits[1]);
    CNOT(logicalQubit, encodedQubits[0]);
    
    CCNOT(encodedQubits[0], encodedQubits[1], logicalQubit);
}

operation EncodePhaseFlip(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit is Adj {
    Fact(
        Length(encodedQubits) == 2,
        "There should be only 2 encoded Qubits"
    );
    // TODO
    CNOT(logicalQubit, encodedQubits[0]);
    CNOT(logicalQubit, encodedQubits[1]);
}

operation DecodePhaseFlip(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit is Adj {
    Fact(
        Length(encodedQubits) == 2,
        "There should be only 2 encoded Qubits"
    );
    // TODO
    CNOT(logicalQubit, encodedQubits[1]);
    CNOT(logicalQubit, encodedQubits[0]);
    
    CCNOT(encodedQubits[0], encodedQubits[1], logicalQubit);
}

operation TestBitFlip(): Result[] {
    // TODO
    use logicalQubit = Qubit();
    use encodedQubits = Qubit[2];

    // No problem
    Message("No problem");
    H(logicalQubit);

    EncodeBitFlip(logicalQubit, encodedQubits);
    DecodeBitFlip(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);
    
    // Error : apply X
    Message("Error: apply X");
    H(logicalQubit);

    EncodeBitFlip(logicalQubit, encodedQubits);
    X(logicalQubit);
    DecodeBitFlip(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    return [Zero];
}

operation TestPhaseFlip(): Result[] {
    // TODO
    use logicalQubit = Qubit();
    use encodedQubits = Qubit[2];

    // No problem
    Message("No problem");
    H(logicalQubit);

    EncodePhaseFlip(logicalQubit, encodedQubits);
    DecodePhaseFlip(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    // Error : phase flip
    Message("Error: phase flip");
    H(logicalQubit);

    EncodePhaseFlip(logicalQubit, encodedQubits);
    ApplyToEach(H, [logicalQubit, encodedQubits[0], encodedQubits[1]]);
    X(logicalQubit);
    ApplyToEach(H, [logicalQubit, encodedQubits[0], encodedQubits[1]]);
    DecodePhaseFlip(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    return [Zero];
}

@EntryPoint()
operation Main() : Unit {
    use logicalQubit = Qubit();
    use encodedQubits = Qubit[2];

    H(logicalQubit);

    EncodePhaseFlip(logicalQubit, encodedQubits);
    ApplyToEach(H, [logicalQubit, encodedQubits[0], encodedQubits[1]]);
    X(logicalQubit);
    ApplyToEach(H, [logicalQubit, encodedQubits[0], encodedQubits[1]]);
    DecodePhaseFlip(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);
}