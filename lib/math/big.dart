import 'package:decimal/decimal.dart';

typedef BigNumberValue
    = dynamic; // In Dart, you can use dynamic type for mixed types

// class BigNumberZeroDecimal {
//   static final Decimal zeroDecimal = Decimal.parse('0');
//   static final int decimalPlaces = 0;
//   static final int roundingMode = Decimal.ROUND_DOWN;
// }

Decimal valueToBigNumber(BigNumberValue amount) {
  if (amount is Decimal) {
    return amount;
  } else if (amount is String) {
    return Decimal.parse(amount);
  } else if (amount is num) {
    return Decimal.parse(amount.toString());
  } else if (amount is BigInt) {
    return Decimal.fromBigInt(amount);
  } else {
    throw ArgumentError('Unsupported type');
  }
}

Decimal valueToZDBigNumber(BigNumberValue amount) {
  Decimal result = valueToBigNumber(amount);
  return result.floor();
}

Decimal normalize(BigNumberValue n, int decimals) {
  return normalizeBN(n, decimals);
}

Decimal normalizeBN(BigNumberValue n, int decimals) {
  return valueToBigNumber(n).shift(-decimals);
}

// void main() {
//   // 示例测试
//   Decimal decimalValue = Decimal.parse('1000000000000000000');
//   Decimal normalized = normalizeBN(decimalValue, 18);
//   print('Normalized value: $normalized'); // Output: Normalized value: 1

//   String normalizedString = normalize(decimalValue, 18);
//   print(
//       'Normalized value as string: $normalizedString'); // Output: Normalized value as string: 1
// }
