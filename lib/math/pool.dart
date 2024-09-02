import 'package:decimal/decimal.dart';

import './const.dart';
import './ray.dart';

BigInt binomialApproximatedRayPow(BigInt a, BigInt p) {
  final base = a;
  final exp = p;
  if (exp == BigInt.zero) return RAY;

  final expMinusOne = exp - BigInt.one;
  final expMinusTwo = exp > BigInt.two ? exp - BigInt.two : BigInt.zero;

  final basePowerTwo = rayMul(base, base);
  final basePowerThree = rayMul(basePowerTwo, base);

  final firstTerm = exp * base;
  final secondTerm = exp * expMinusOne * basePowerTwo ~/ BigInt.two;
  final thirdTerm =
      exp * expMinusOne * expMinusTwo * basePowerThree ~/ BigInt.from(6);

  return RAY + firstTerm + (secondTerm + thirdTerm);
}

// Main calculation functions
BigInt calculateCompoundedInterest({
  required BigInt rate,
  required int currentTimestamp,
  required int lastUpdateTimestamp,
}) {
  final timeDelta = currentTimestamp - lastUpdateTimestamp;
  final ratePerSecond = rate ~/ SECONDS_PER_YEAR;
  return binomialApproximatedRayPow(ratePerSecond, BigInt.from(timeDelta));
}

BigInt getCompoundedBalance({
  required BigInt principalBalance,
  required BigInt reserveIndex,
  required BigInt reserveRate,
  required int lastUpdateTimestamp,
  required int currentTimestamp,
}) {
  final principal = principalBalance;
  if (principal == BigInt.zero) {
    return principal;
  }

  final compoundedInterest = calculateCompoundedInterest(
    rate: reserveRate,
    currentTimestamp: currentTimestamp,
    lastUpdateTimestamp: lastUpdateTimestamp,
  );
  final cumulatedInterest = rayMul(compoundedInterest, reserveIndex);
  final principalBalanceRay = wadToRay(principal);

  return rayToWad(rayMul(principalBalanceRay, cumulatedInterest));
}

BigInt calculateLinearInterest({
  required BigInt rate,
  required BigInt currentTimestamp,
  required BigInt lastUpdateTimestamp,
}) {
  final timeDelta = wadToRay((currentTimestamp - lastUpdateTimestamp));
  final timeDeltaInSeconds = rayDiv(timeDelta, wadToRay(SECONDS_PER_YEAR));
  final a = rayMul(rate, timeDeltaInSeconds) + RAY;
  return a;
}

BigInt getReserveNormalizedIncome({
  required BigInt rate,
  required BigInt index,
  required BigInt lastUpdateTimestamp,
  required BigInt currentTimestamp,
}) {
  if (rate == BigInt.zero) {
    return index;
  }

  final cumulatedInterest = calculateLinearInterest(
    rate: rate,
    currentTimestamp: currentTimestamp,
    lastUpdateTimestamp: lastUpdateTimestamp,
  );

  return rayMul(cumulatedInterest, index);
}

BigInt getLinearBalance({
  required BigInt balance,
  required BigInt index,
  required BigInt rate,
  required BigInt lastUpdateTimestamp,
  required BigInt currentTimestamp,
}) {
  return rayToWad(rayMul(
    wadToRay(balance),
    getReserveNormalizedIncome(
      rate: rate,
      index: index,
      lastUpdateTimestamp: lastUpdateTimestamp,
      currentTimestamp: currentTimestamp,
    ),
  ));
}

BigInt getCompoundedStableBalance({
  required BigInt principalBalance,
  required BigInt userStableRate,
  required int lastUpdateTimestamp,
  required int currentTimestamp,
}) {
  final principal = principalBalance;
  if (principal == BigInt.zero) {
    return principal;
  }

  final cumulatedInterest = calculateCompoundedInterest(
    rate: userStableRate,
    currentTimestamp: currentTimestamp,
    lastUpdateTimestamp: lastUpdateTimestamp,
  );
  final principalBalanceRay = wadToRay(principal);

  return rayToWad(rayMul(principalBalanceRay, cumulatedInterest));
}

Decimal calculateHealthFactorFromBalances({
  required Decimal collateralBalanceMarketReferenceCurrency,
  required Decimal borrowBalanceMarketReferenceCurrency,
  required Decimal currentLiquidationThreshold,
}) {
  if (borrowBalanceMarketReferenceCurrency == Decimal.zero) {
    return Decimal.zero;
  }

  final h =
      (collateralBalanceMarketReferenceCurrency * currentLiquidationThreshold)
              .shift(-LTV_PRECISION)
              .toBigInt() ~/
          borrowBalanceMarketReferenceCurrency.toBigInt();
  return h.toDecimal();
}

Decimal calculateHealthFactorFromBalancesBigUnits({
  required Decimal collateralBalanceMarketReferenceCurrency,
  required Decimal borrowBalanceMarketReferenceCurrency,
  required Decimal currentLiquidationThreshold,
}) {
  return calculateHealthFactorFromBalances(
          collateralBalanceMarketReferenceCurrency:
              collateralBalanceMarketReferenceCurrency,
          borrowBalanceMarketReferenceCurrency:
              borrowBalanceMarketReferenceCurrency,
          currentLiquidationThreshold: currentLiquidationThreshold)
      .shift(LTV_PRECISION);
}

Decimal calculateAvailableBorrowsMarketReferenceCurrency({
  required BigInt collateralBalanceMarketReferenceCurrency,
  required BigInt borrowBalanceMarketReferenceCurrency,
  required BigInt currentLtv,
}) {
  if (currentLtv == BigInt.zero) {
    return Decimal.zero;
  }

  final availableBorrows =
      collateralBalanceMarketReferenceCurrency.toDecimal() *
              currentLtv.toDecimal().shift(-LTV_PRECISION) -
          borrowBalanceMarketReferenceCurrency.toDecimal();

  return availableBorrows > Decimal.zero ? availableBorrows : Decimal.zero;
}

class MarketReferenceAndUsdBalanceResponse {
  final Decimal marketReferenceCurrencyBalance;
  final Decimal usdBalance;

  MarketReferenceAndUsdBalanceResponse({
    required this.marketReferenceCurrencyBalance,
    required this.usdBalance,
  });
}

MarketReferenceAndUsdBalanceResponse getMarketReferenceCurrencyAndUsdBalance({
  required BigInt balance,
  required BigInt priceInMarketReferenceCurrency,
  required int marketReferenceCurrencyDecimals,
  required int decimals,
  required BigInt marketReferencePriceInUsdNormalized,
}) {
  final marketReferenceCurrencyBalance =
      (balance * priceInMarketReferenceCurrency).toDecimal().shift(-decimals);
  final usdBalance = (marketReferenceCurrencyBalance *
          marketReferencePriceInUsdNormalized.toDecimal())
      .shift(-marketReferenceCurrencyDecimals);
  return MarketReferenceAndUsdBalanceResponse(
    marketReferenceCurrencyBalance: marketReferenceCurrencyBalance,
    usdBalance: usdBalance,
  );
}
