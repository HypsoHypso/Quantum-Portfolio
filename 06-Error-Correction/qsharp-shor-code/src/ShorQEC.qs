import Std.Math.PI;
import Std.Diagnostics.DumpMachine;
import Std.Diagnostics.PhaseFlipNoise;
import Std.Diagnostics.Fact;
import SimpleQEC.*;

operation EncodeShorCode(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit is Adj {
    Fact(
        Length(encodedQubits) == 8,
        "There should be only 8 qubits"
    );
    // TODO
    EncodePhaseFlip(logicalQubit, [encodedQubits[2], encodedQubits[5]]);
    
    ApplyToEachA(H, [logicalQubit, encodedQubits[2], encodedQubits[5]]);
    
    EncodeBitFlip(logicalQubit, [encodedQubits[0], encodedQubits[1]]);
    EncodeBitFlip(encodedQubits[2], [encodedQubits[3], encodedQubits[4]]);
    EncodeBitFlip(encodedQubits[5], [encodedQubits[6], encodedQubits[7]]);
}

operation DecodeShorCode(logicalQubit: Qubit, encodedQubits: Qubit[]): Unit {
    Fact(
        Length(encodedQubits) == 8,
        "There should be only 8 qubits"
    );
    // TODO
    DecodeBitFlip(logicalQubit, [encodedQubits[0], encodedQubits[1]]);
    DecodeBitFlip(encodedQubits[2], [encodedQubits[3], encodedQubits[4]]);
    DecodeBitFlip(encodedQubits[5], [encodedQubits[6], encodedQubits[7]]);

    ApplyToEachA(H, [logicalQubit, encodedQubits[2], encodedQubits[5]]);

    DecodePhaseFlip(logicalQubit, [encodedQubits[2], encodedQubits[5]]);
}

operation TestShor(): Result[] {
    // No problem
    Message("No problem");
    use logicalQubit = Qubit();
    use encodedQubits = Qubit[8];

    H(logicalQubit);

    EncodeShorCode(logicalQubit, encodedQubits);
    DecodeShorCode(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    // X Error
    Message("X error");

    EncodeShorCode(logicalQubit, encodedQubits);
    X(logicalQubit);
    DecodeShorCode(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    // Z Error
    Message("Z error");
    H(logicalQubit);
    R1(PI() / 7., logicalQubit);

    DumpMachine();

    EncodeShorCode(logicalQubit, encodedQubits);
    
    Z(logicalQubit);

    DecodeShorCode(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);


    // Z & X Error
    Message("Z & X error");
    H(logicalQubit);
    R1(PI() / 7., logicalQubit);

    DumpMachine();

    EncodeShorCode(logicalQubit, encodedQubits);
    
    X(logicalQubit);
    Z(logicalQubit);

    DecodeShorCode(logicalQubit, encodedQubits);

    DumpMachine();

    Reset(logicalQubit);
    ResetAll(encodedQubits);

    return [Zero];
}