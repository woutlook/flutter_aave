import 'package:decimal/decimal.dart';
import 'big.dart';

class NativeToUSD {
  final Decimal amount;
  final int currencyDecimals;
  final BigNumberValue priceInMarketReferenceCurrency;
  final int marketReferenceCurrencyDecimals;
  final BigNumberValue normalizedMarketReferencePriceInUsd;

  NativeToUSD({
    required this.amount,
    required this.currencyDecimals,
    required this.priceInMarketReferenceCurrency,
    required this.marketReferenceCurrencyDecimals,
    required this.normalizedMarketReferencePriceInUsd,
  });
}

Decimal nativeToUSD(NativeToUSD params) {
  final amount = params.amount;
  final currencyDecimals = params.currencyDecimals;
  final priceInMarketReferenceCurrency =
      valueToBigNumber(params.priceInMarketReferenceCurrency);
  final marketReferenceCurrencyDecimals =
      params.marketReferenceCurrencyDecimals;
  final normalizedMarketReferencePriceInUsd =
      valueToBigNumber(params.normalizedMarketReferencePriceInUsd);

  final result = amount *
      priceInMarketReferenceCurrency *
      normalizedMarketReferencePriceInUsd;

  return result
      .shift((currencyDecimals + marketReferenceCurrencyDecimals) * -1);
}

Decimal normalizedToUsd(
  Decimal value,
  Decimal marketReferencePriceInUsd,
  int marketReferenceCurrencyDecimals,
) {
  return (value * marketReferencePriceInUsd)
      .shift(marketReferenceCurrencyDecimals * -1);
}
