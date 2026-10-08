import Std.Diagnostics.DumpMachine;
import Std.Diagnostics.Fact;
import UGate.AddConstantModulo;
import Std.Math.ExpModI;
import UGate.MultiplyConstantModulo;

operation ExpMod(generator : Int, power : Int, modulo : Int) : Int
{
    ExpModI(generator, (1 <<< power), modulo);
    return 0;
}

operation ApplyUGate(generator: Int, modulo: Int, power: Int, qs: Qubit[], naive : Bool): Unit is Adj + Ctl {
    // TODO

    // Modified for benchmark for the presentation
    if (naive) {
        for i in 1..power {
            MultiplyConstantModulo(generator, modulo, qs);
        }
    } else {
        MultiplyConstantModulo(ExpModI(generator, power, modulo), modulo, qs);        
    }
}

operation ApplyUGateNaive(generator: Int, modulo: Int, power: Int, nbQubits : Int): Int {
    use qs = Qubit[nbQubits];
    X(qs[0]);
    
    for i in 1..(1 <<< power) {
        MultiplyConstantModulo(generator, modulo, qs);
    }

    ResetAll(qs);

    return 0;
}

operation ApplyUGateOptimized(generator: Int, modulo: Int, power: Int, nbQubits : Int): Int {
    use qs = Qubit[nbQubits];
    X(qs[0]);
    
    let exp = ExpModI(generator, (1 <<< power), modulo);
    MultiplyConstantModulo(exp, modulo, qs);

    ResetAll(qs);       

    return 0;
}

operation ApplyUGateBenchmark(generator: Int, modulo: Int, power: Int, naive : Bool) : Int {
    // TODO

    use qs = Qubit[12];
    X(qs[0]);

    DumpMachine();

    // Modified for benchmark for the presentation
    if (naive) {
        for i in 1..power {
            MultiplyConstantModulo(generator, modulo, qs);
        }
    } else {
        MultiplyConstantModulo(ExpModI(generator, power, modulo), modulo, qs);        
    }

    DumpMachine();

    ResetAll(qs);

    return 0;
}

operation EstimateFrequency(generator: Int, modulo: Int, moduloBitSize: Int, naive : Bool): Int {
    // TODO
    mutable frequency = 0;
    let bitsPrecision = 2 * moduloBitSize + 1;
    use qs = Qubit[moduloBitSize];
    X(qs[0]);
    use c = Qubit();

    for i in RangeReverse(0..bitsPrecision-1) {
        H(c);
        Controlled ApplyUGate([c], (generator, modulo, 1 <<< i, qs, naive));
        R1Frac(frequency, bitsPrecision - 1 - i, c);
        // Message($"{frequency}");
        H(c);
        let c_measure = M(c);
        if (c_measure == One) {
            frequency += 1 <<< (bitsPrecision - 1 - i);
            // Message($"Updated {frequency}");
            X(c);
        }
    }

    ResetAll(qs);

    return frequency;
}

operation test(): Int {
    let frequency = EstimateFrequency(2, 15, 4, false);
    Message($"Fréquence : {frequency}");
    let isValid = frequency == 0 or frequency == 128
    or frequency == 256 or frequency == 384;
    Fact(isValid, $"Fréquence {frequency} inattendue");

    return frequency;
}

operation test2(): Int {
    mutable count0 = 0; mutable count128 = 0;
    mutable count256 = 0; mutable count384 = 0;
    for _ in 1..40 {
        let freq = EstimateFrequency(2, 15, 4, false);
        if freq == 0 { count0 += 1; }
        elif freq == 128 { count128 += 1; Message("128"); }
        elif freq == 256 { count256 += 1; Message("256"); }
        elif freq == 384 { count384 += 1; Message("384"); }
    }
    Message($"0={count0}, 128={count128}, 256={count256}, 384={count384}");
    
    return 0;
}

operation TestFrequencyN21() : Unit {
    // N=21, g=2, ordre 6. Fréquences attendues proches de s * 2^11 / 6
    // soit 0, 341, 683, 1024, 1365, 1707 (approximations entières)
    mutable counts = [0, 0, 0, 0, 0, 0];
    for _ in 1..30 {
        let freq = EstimateFrequency(2, 21, 5, false);
        // bitsPrecision = 11, donc 2^11 = 2048
        // On classe chaque mesure dans le bin le plus proche
        let bin = (freq * 6 + 1024) / 2048;       // 0..5
        if bin < 6 { counts w/= bin <- counts[bin] + 1; }
    }
    Message($"N=21, g=2 distribution sur les 6 bins: {counts}");
    // Les 6 bins devraient tous avoir au moins une occurrence
}

operation TestFrequencyN35() : Unit {
    // N=35, g=2, ordre 12. Test plus exigeant (12 valeurs possibles)
    let freq = EstimateFrequency(2, 35, 6, false);
    Message($"N=35, g=2: freq={freq}, attendu proche d'un multiple de 2^13/12 = 682.67");
    // Les valeurs proches sont 0, 683, 1365, 2048, 2731, 3413, 4096, ...
}

operation TestSimpleCaseStatistical() : Unit {
    let generator = 2;
    let modulo = 15;
    let moduloBitSize = 4;
    
    mutable count0 = 0;
    mutable count128 = 0;
    mutable count256 = 0;
    mutable count384 = 0;
    mutable countOther = 0;
    
    for _ in 1..40 {
        let frequency = EstimateFrequency(generator, modulo, moduloBitSize, false);
        if frequency == 0 { count0 += 1; }
        elif frequency == 128 { count128 += 1; }
        elif frequency == 256 { count256 += 1; }
        elif frequency == 384 { count384 += 1; }
        else { countOther += 1; }
    }
    
    Message($"Sur 40 runs: 0={count0}, 128={count128}, 256={count256}, 384={count384}, autre={countOther}");
    Fact(countOther == 0, "Une fréquence inattendue est apparue");
    // Chaque valeur devrait apparaître environ 10 fois (loi des grands nombres)
}