import Std.Diagnostics.DumpMachine;
import Std.Math.ExpModI;
import UGate.MultiplyConstantModulo;

operation ApplyUGateNaive(generator: Int, modulo: Int, power: Int, qs: Qubit[]): Unit is Adj + Ctl {
    for i in 1..(1 <<< power) {
        MultiplyConstantModulo(generator, modulo, qs);
    }
}
operation ApplyUGateOptimised(generator: Int, modulo: Int, power: Int, qs: Qubit[]): Unit is Adj + Ctl {
    MultiplyConstantModulo(ExpModI(generator, power, modulo), modulo, qs);
}

operation test(): Result[] {
    use qs = Qubit[4];
    X(qs[0]);

    ApplyUGateNaive(4, 15, 1, qs);

    DumpMachine();

    return MResetEachZ(qs);
}