import QPE.QPE;
import Std.Math.PI;

operation QPEPhi(phi: Double, nbAncillas: Int): Result[] {
    // TODO
    use q = Qubit();
    X(q);

    let result = QPE(((p) => R1(2.0 * PI() * phi, p)), q, nbAncillas);

    X(q);

    return result;
}

operation Main() : Result[] {
    
    let res = QPEPhi(0.5, 4); // Returns [One, Zero, Zero, Zero] => CORRECT
    // let res = QPEPhi(0.75, 4); // Returns [One, One, Zero, Zero] => CORRECT
    // let res = QPEPhi(0.25, 4); // Returns [Zero, One, Zero, Zero] => CORRECT
    // let res = QPEPhi(0.125, 4); // Returns [Zero, Zero, One, Zero] => CORRECT

    return res;
}