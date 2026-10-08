import PhaseEstimation.ApplyUGateNaive;
import Std.Random.DrawRandomInt;
import PhaseEstimation.EstimateFrequency;
import Std.Math.BitSizeI;
import Std.Diagnostics.Fact;
import Std.Math.Max;
import Std.Math.ExpModI;
import Std.Math.GreatestCommonDivisorI;
import Std.Math.AbsI;
import Std.Math.ContinuedFractionConvergentI;


operation FactorSemiprimeInteger(number : Int, naive : Bool) : (Int, Int) {
    // TODO
    if (number%2 == 0) {
        return (number/2, 2);
    }
    mutable foundFactors = false;
    mutable factors = (1, 1);
    mutable attempt = 1;

    repeat {
        let g = DrawRandomInt(1, number-1);
        let gcd = GreatestCommonDivisorI(g, number);
        if gcd == 1 {
            let period = EstimatePeriod(g, number, naive);
            (foundFactors, factors) = MaybeFactorsFromPeriod(number, g, period);
        } else {
            (foundFactors, factors) = (true, (gcd, number/gcd));
        }
        attempt += 1;
        if attempt > 100 {fail "Attempt > 100"}
    } until foundFactors fixup {
        Message("Not yet");
    }
    return factors;
}

function MaybeFactorsFromPeriod(
    modulus : Int,
    generator : Int,
    period : Int
) : (Bool, (Int, Int)) {
    
    if (period % 2 == 1) {
        return (false, (1, 1));
    }

    mutable h = ExpModI(generator, period / 2, modulus);
    if (h == modulus - 1) {
        return (false, (1, 1));
    } else {
        mutable f1 = GreatestCommonDivisorI(h - 1, modulus);
        mutable f2 = GreatestCommonDivisorI(h + 1, modulus);
        
        let f = Max([f1, f2]);
        if (f > 1 and f < modulus) {
            return (true, (f, modulus / f));
        } else {
            return (false, (1, 1));
        }
    }

    return (true, (1214, 1804))
}

function PeriodFromFrequency(modulo: Int, frequency: Int, bitsPrecision: Int, currentDivisor: Int) : Int {
    // TODO
    mutable (s, r) = ContinuedFractionConvergentI((frequency, (1 <<< bitsPrecision)), modulo);
    s = AbsI(s);
    r = AbsI(r);

    mutable finalPeriod = r * currentDivisor;
    finalPeriod /= GreatestCommonDivisorI(currentDivisor, r);

    return finalPeriod;
}

operation EstimatePeriod(generator: Int, modulo: Int, naive : Bool): Int {
    // TODO
    Fact(GreatestCommonDivisorI(generator, modulo) == 1, $"gcd({generator},{modulo}={GreatestCommonDivisorI(generator, modulo)})");
    let bitSize = BitSizeI(modulo);
    let frequency = EstimateFrequency(generator, modulo, bitSize, naive);

    mutable period = 1;
    if frequency != 0 {
        period = PeriodFromFrequency(modulo, frequency, 2*bitSize + 1, 1);
    }
    return period;
}

operation test(): Int {
    let p1 = PeriodFromFrequency(15, 128, 9, 1);
    // attendu : 4 (car 128/512 = 1/4, période 4)
    let p2 = PeriodFromFrequency(15, 256, 9, 1);
    // attendu : 2 (car 256/512 = 1/2, diviseur de 4)
    let p3 = PeriodFromFrequency(15, 384, 9, 1);
    // attendu : 4 (car 384/512 = 3/4, période 4)
    let p4 = PeriodFromFrequency(15, 0, 9, 1);
    // attendu : 0 ou 1 (cas dégénéré ; EstimatePeriod filtre ce cas en amont)
    let p5 = PeriodFromFrequency(15, 128, 9, 2);
    // attendu : 4 (lcm(2, 4) = 4 ; combinaison avec un diviseur précédent)
    
    Message($"{p1}, {p2}, {p3}, {p4}, {p5}");

    return 0;
}

operation testPeriod(): Int {
    let p1 = EstimatePeriod(2, 15, false);
    let p2 = EstimatePeriod(7, 15, false);
    let p3 = EstimatePeriod(2, 21, false);

    return p3;
}

operation testMaybeFactor(): Bool {
    let (ok1, (a1, b1)) = MaybeFactorsFromPeriod(15, 2, 4);
    // attendu : (true, (5, 3)) car 2ˆ2 mod 15 = 4
    let (ok2, (a2, b2)) = MaybeFactorsFromPeriod(15, 4, 2);
    // attendu : (true, (5, 3)) car 4ˆ1 mod 15 = 4
    let (ok3, (a3, b3)) = MaybeFactorsFromPeriod(21, 2, 6);
    // attendu : (true, (7, 3)) car 2ˆ3 mod 21 = 8
    let (ok4, (a4, b4)) = MaybeFactorsFromPeriod(15, 7, 4);
    // attendu : (true, ...) car 7ˆ2 mod 15 = 49 mod 15 = 4
    let (ok5, (a5, b5)) = MaybeFactorsFromPeriod(15, 2, 3);
    // attendu : (false, (1, 1)) car r impair
    let (ok6, (a6, b6)) = MaybeFactorsFromPeriod(15, 14, 2);
    // attendu : (false, (1, 1)) car 14ˆ1 mod 15 = 14 = N-1 (cas trivial)

    Message($"{ok1}, {a1},{b1}");
    Message($"{ok2}, {a2},{b2}");
    Message($"{ok3}, {a3},{b3}");
    Message($"{ok4}, {a4},{b4}");
    Message($"{ok5}, {a5},{b5}");
    Message($"{ok6}, {a6},{b6}");

    return ok1;
}

operation testSemi(): (Int, Int) {
    // let (a, b) = FactorSemiprimeInteger(15);
    // attendu : (5, 3) ou (3, 5)
    // let (a, b) = FactorSemiprimeInteger(21);
    // attendu : (3, 7) ou (7, 3) ou (3, 7) par chemin classique
    let (a, b) = FactorSemiprimeInteger(15, false);
    // attendu : (5, 7) ou (7, 5)

    return (a,b);
}

operation Shor(n : Int, naive : Bool): (Int, Int) {
    let (a, b) = FactorSemiprimeInteger(n, naive);

    return (a,b);
}

// operation naive_test(): Int {
//     ApplyUGateNaive(4, 15, 10, log);
    
//     return 0;
// }