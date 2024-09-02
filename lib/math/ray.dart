// ignore_for_file: non_constant_identifier_names

final BigInt WAD = BigInt.from(10).pow(18);
final BigInt HALF_WAD = WAD ~/ BigInt.two;

final BigInt RAY = BigInt.from(10).pow(27);
final BigInt HALF_RAY = RAY ~/ BigInt.two;

final BigInt WAD_RAY_RATIO = BigInt.from(10).pow(9);

BigInt rayMul(BigInt a, BigInt b) {
  return (HALF_RAY + (a * b)) ~/ RAY;
}

BigInt rayDiv(BigInt a, BigInt b) {
  final half = b ~/ BigInt.two;
  return (half + (a * RAY)) ~/ b;
}

BigInt rayToWad(BigInt a) {
  BigInt halfRatio = WAD_RAY_RATIO ~/ BigInt.two;
  return (halfRatio + a) ~/ WAD_RAY_RATIO;
}

BigInt wadToRay(BigInt a) {
  return a * WAD_RAY_RATIO;
}

BigInt rayPow(BigInt a, BigInt p) {
  var x = a;
  var n = p;
  var z = n % BigInt.two == BigInt.zero ? RAY : x;

  for (n = n ~/ BigInt.two; n != BigInt.zero; n = (n ~/ BigInt.two)) {
    x = rayMul(x, x);

    if (n % BigInt.two != BigInt.zero) {
      z = rayMul(z, x);
    }
  }
  return z;
}

BigInt binomialApproximatedRayPow(BigInt a, BigInt p) {
  BigInt base = a;
  BigInt exp = p;
  if (exp == BigInt.zero) return RAY;

  BigInt expMinusOne = exp - BigInt.one;
  BigInt expMinusTwo = exp > BigInt.two ? exp - BigInt.two : BigInt.zero;

  BigInt basePowerTwo = rayMul(base, base);
  BigInt basePowerThree = rayMul(basePowerTwo, base);

  BigInt firstTerm = exp * base;
  BigInt secondTerm = exp * expMinusOne * basePowerTwo ~/ BigInt.two;
  BigInt thirdTerm =
      exp * expMinusOne * expMinusTwo * basePowerThree ~/ BigInt.from(6);

  return RAY + firstTerm + secondTerm + thirdTerm;
}
