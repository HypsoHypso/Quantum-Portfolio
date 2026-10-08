// Q# uses little-endian notation
// E.g. |001> in Q# is 4 and |100> is 1.
// The least-significant bit is at qs[0]
import Std.Arrays.IndexRange;
operation Oracle(secret: Int, qs: Qubit[]): Unit {
    // TODO
    use aux = Qubit();
    X(aux);
    H(aux);
    mutable s = secret;
    for i in IndexRange(qs) {
        if (s % 2 == 1) {
            CNOT(qs[i], aux);
        }
        s /= 2;
    }
    Reset(aux);
}

operation BernsteinVazirani(): Result[] {
    // TODO
    use qs = Qubit[4];
    ApplyToEach(H, qs);
    let secret = 13;
    Oracle(secret, qs);
    ApplyToEach(H, qs);

    return MResetEachZ(qs);
}
