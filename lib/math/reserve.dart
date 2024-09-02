import 'package:decimal/decimal.dart';
import 'package:tlend_app/models/reserve.dart';

import './const.dart';
import './big.dart';
import './usd.dart';
import './ray.dart';
import './pool.dart';

class CalculateCompoundedInterestRequest {
  final BigInt rate;
  final BigInt currentTimestamp;
  final BigInt lastUpdateTimestamp;

  CalculateCompoundedInterestRequest({
    required this.rate,
    required this.currentTimestamp,
    required this.lastUpdateTimestamp,
  });
}

class CalculateReserveDebtRequest {
  final BigInt totalScaledVariableDebt;
  final BigInt variableBorrowIndex;
  final BigInt totalPrincipalStableDebt;
  final BigInt availableLiquidity;
  final BigInt variableBorrowRate;
  final BigInt lastUpdateTimestamp;
  final BigInt averageStableRate;
  final BigInt stableDebtLastUpdateTimestamp;

  CalculateReserveDebtRequest({
    required this.totalScaledVariableDebt,
    required this.variableBorrowIndex,
    required this.totalPrincipalStableDebt,
    required this.availableLiquidity,
    required this.variableBorrowRate,
    required this.lastUpdateTimestamp,
    required this.averageStableRate,
    required this.stableDebtLastUpdateTimestamp,
  });

  factory CalculateReserveDebtRequest.fromReserveData(
      AggregatedReserveData reserve) {
    return CalculateReserveDebtRequest(
      variableBorrowIndex: reserve.variableBorrowIndex,
      totalScaledVariableDebt: reserve.totalScaledVariableDebt,
      totalPrincipalStableDebt: reserve.totalPrincipalStableDebt,
      availableLiquidity: reserve.availableLiquidity,
      variableBorrowRate: reserve.variableBorrowRate,
      lastUpdateTimestamp: reserve.lastUpdateTimestamp,
      averageStableRate: reserve.averageStableRate,
      stableDebtLastUpdateTimestamp: reserve.stableDebtLastUpdateTimestamp,
    );
  }
}

class CalculateReserveDebtResponse {
  final Decimal totalVariableDebt;
  final Decimal totalStableDebt;
  final Decimal totalDebt;
  final Decimal totalLiquidity;

  CalculateReserveDebtResponse({
    required this.totalVariableDebt,
    required this.totalStableDebt,
    required this.totalDebt,
    required this.totalLiquidity,
  });
}

CalculateReserveDebtResponse calculateReserveDebt(
  CalculateReserveDebtRequest reserveDebt,
  int currentTimestamp,
) {
  final totalVariableDebt = getTotalVariableDebt(reserveDebt, currentTimestamp);
  final totalStableDebt = getTotalStableDebt(reserveDebt, currentTimestamp);
  final totalDebt = totalVariableDebt + totalStableDebt;
  final totalLiquidity = totalDebt + reserveDebt.availableLiquidity.toDecimal();

  return CalculateReserveDebtResponse(
    totalVariableDebt: totalVariableDebt,
    totalStableDebt: totalStableDebt,
    totalDebt: totalDebt,
    totalLiquidity: totalLiquidity,
  );
}

Decimal getTotalVariableDebt(
  CalculateReserveDebtRequest reserveDebt,
  int currentTimestamp,
) {
  final interest = calculateCompoundedInterest(
    rate: reserveDebt.variableBorrowRate,
    currentTimestamp: currentTimestamp,
    lastUpdateTimestamp: reserveDebt.lastUpdateTimestamp.toInt(),
  );
  return rayMul(
          rayMul(reserveDebt.totalScaledVariableDebt,
              reserveDebt.variableBorrowIndex),
          interest)
      .toDecimal();
}

Decimal getTotalStableDebt(
  CalculateReserveDebtRequest reserveDebt,
  int currentTimestamp,
) {
  final interest = calculateCompoundedInterest(
    rate: reserveDebt.averageStableRate,
    currentTimestamp: currentTimestamp,
    lastUpdateTimestamp: reserveDebt.stableDebtLastUpdateTimestamp.toInt(),
  );
  return rayMul(reserveDebt.totalPrincipalStableDebt, interest).toDecimal();
}

class GetComputedReserveFieldsResponse {
  Decimal formattedReserveLiquidationBonus;
  Decimal formattedEModeLtv;
  Decimal formattedEModeLiquidationThreshold;
  Decimal formattedEModeLiquidationBonus;
  Decimal formattedAvailableLiquidity;
  Decimal totalDebt;
  Decimal totalStableDebt;
  Decimal totalVariableDebt;
  Decimal totalLiquidity;
  Decimal borrowUsageRatio;
  Decimal supplyUsageRatio;
  Decimal supplyAPY;
  Decimal variableBorrowAPY;
  Decimal stableBorrowAPY;
  Decimal unborrowedLiquidity;

  GetComputedReserveFieldsResponse({
    required this.formattedReserveLiquidationBonus,
    required this.formattedEModeLtv,
    required this.formattedEModeLiquidationThreshold,
    required this.formattedEModeLiquidationBonus,
    required this.formattedAvailableLiquidity,
    required this.totalDebt,
    required this.totalStableDebt,
    required this.totalVariableDebt,
    required this.totalLiquidity,
    required this.borrowUsageRatio,
    required this.supplyUsageRatio,
    required this.supplyAPY,
    required this.variableBorrowAPY,
    required this.stableBorrowAPY,
    required this.unborrowedLiquidity,
  });
}

BigInt calculateCompoundedRate({
  required BigInt rate,
  required BigInt duration,
}) {
  return rayPow(rate ~/ SECONDS_PER_YEAR + RAY, duration) - RAY;
}

GetComputedReserveFieldsResponse getComputedReserveFields(
  AggregatedReserveData reserve,
  int currentTimestamp,
) {
  final reserveDebt = calculateReserveDebt(
      CalculateReserveDebtRequest.fromReserveData(reserve), currentTimestamp);
  final totalDebt = reserveDebt.totalDebt;
  final totalStableDebt = reserveDebt.totalStableDebt;
  final totalVariableDebt = reserveDebt.totalVariableDebt;
  final totalLiquidity = reserveDebt.totalLiquidity;

  final borrowUsageRatio = totalLiquidity == Decimal.zero
      ? Decimal.zero
      : (totalDebt / totalLiquidity).toDecimal(scaleOnInfinitePrecision: 27);
  final supplyUsageRatio = totalLiquidity == Decimal.zero
      ? Decimal.zero
      : (totalDebt / (totalLiquidity + reserve.unbacked.toDecimal()))
          .toDecimal(scaleOnInfinitePrecision: 27);

  final reserveLiquidationBonus = normalize(
    reserve.reserveLiquidationBonus.toDecimal() - 10.toDecimal(),
    LTV_PRECISION,
  );

  final eModeLiquidationBonus = normalize(
    reserve.eModeLiquidationBonus.toDecimal() - 10.toDecimal(),
    LTV_PRECISION,
  );

  final a = reserve.availableLiquidity.toDecimal();
  final b = reserve.borrowCap.toDecimal().shift(reserve.decimals.toInt()) -
      (totalDebt + Decimal.one);

  final availableLiquidity = reserve.borrowCap == BigInt.zero
      ? a
      : a < b
          ? a
          : b;
  final supplyAPY = calculateCompoundedRate(
    rate: reserve.liquidityRate,
    duration: SECONDS_PER_YEAR,
  );

  final variableBorrowAPY = calculateCompoundedRate(
    rate: reserve.variableBorrowRate,
    duration: SECONDS_PER_YEAR,
  );

  final stableBorrowAPY = calculateCompoundedRate(
    rate: reserve.stableBorrowRate,
    duration: SECONDS_PER_YEAR,
  );

  return GetComputedReserveFieldsResponse(
    formattedReserveLiquidationBonus: reserveLiquidationBonus,
    formattedEModeLtv: reserve.eModeLtv.toDecimal(),
    formattedEModeLiquidationThreshold:
        reserve.eModeLiquidationThreshold.toDecimal(),
    formattedEModeLiquidationBonus: eModeLiquidationBonus,
    formattedAvailableLiquidity: availableLiquidity,
    totalDebt: totalDebt,
    totalStableDebt: totalStableDebt,
    totalVariableDebt: totalVariableDebt,
    totalLiquidity: totalLiquidity,
    borrowUsageRatio: borrowUsageRatio,
    supplyUsageRatio: supplyUsageRatio,
    supplyAPY: supplyAPY.toDecimal(),
    variableBorrowAPY: variableBorrowAPY.toDecimal(),
    stableBorrowAPY: stableBorrowAPY.toDecimal(),
    unborrowedLiquidity: reserve.availableLiquidity.toDecimal(),
  );
}

class FormatReserveResponse {
  AggregatedReserveData reserve;
  Decimal formattedBaseLTVasCollateral;
  Decimal formattedReserveLiquidationThreshold;
  Decimal formattedReserveLiquidationBonus;
  Decimal formattedEModeLtv;
  Decimal formattedEModeLiquidationBonus;
  Decimal formattedEModeLiquidationThreshold;
  Decimal formattedAvailableLiquidity;
  Decimal totalDebt;
  Decimal totalVariableDebt;
  Decimal totalStableDebt;
  Decimal totalLiquidity;
  Decimal borrowUsageRatio;
  Decimal supplyUsageRatio;
  Decimal supplyAPY;
  Decimal variableBorrowAPY;
  Decimal stableBorrowAPY;
  Decimal unborrowedLiquidity;
  Decimal supplyAPR;
  Decimal variableBorrowAPR;
  Decimal stableBorrowAPR;
  bool isIsolated;
  Decimal isolationModeTotalDebtUSD;
  Decimal availableDebtCeilingUSD;
  Decimal debtCeilingUSD;
  Decimal totalScaledVariableDebt;
  Decimal totalPrincipalStableDebt;

  FormatReserveResponse({
    required this.reserve,
    required this.formattedBaseLTVasCollateral,
    required this.formattedReserveLiquidationThreshold,
    required this.formattedReserveLiquidationBonus,
    required this.formattedEModeLtv,
    required this.formattedEModeLiquidationBonus,
    required this.formattedEModeLiquidationThreshold,
    required this.formattedAvailableLiquidity,
    required this.totalDebt,
    required this.totalVariableDebt,
    required this.totalStableDebt,
    required this.totalLiquidity,
    required this.borrowUsageRatio,
    required this.supplyUsageRatio,
    required this.supplyAPY,
    required this.variableBorrowAPY,
    required this.stableBorrowAPY,
    required this.unborrowedLiquidity,
    required this.supplyAPR,
    required this.variableBorrowAPR,
    required this.stableBorrowAPR,
    required this.isIsolated,
    required this.isolationModeTotalDebtUSD,
    required this.availableDebtCeilingUSD,
    required this.debtCeilingUSD,
    required this.totalScaledVariableDebt,
    required this.totalPrincipalStableDebt,
  });

  Map<String, dynamic> toJson() {
    return {
      'reserve': reserve.toJson(),
      'formattedBaseLTVasCollateral': formattedBaseLTVasCollateral.toString(),
      'formattedReserveLiquidationThreshold':
          formattedReserveLiquidationThreshold.toString(),
      'formattedReserveLiquidationBonus':
          formattedReserveLiquidationBonus.toString(),
      'formattedEModeLtv': formattedEModeLtv.toString(),
      'formattedEModeLiquidationBonus':
          formattedEModeLiquidationBonus.toString(),
      'formattedEModeLiquidationThreshold':
          formattedEModeLiquidationThreshold.toString(),
      'formattedAvailableLiquidity': formattedAvailableLiquidity.toString(),
      'totalDebt': totalDebt.toString(),
      'totalVariableDebt': totalVariableDebt.toString(),
      'totalStableDebt': totalStableDebt.toString(),
      'totalLiquidity': totalLiquidity.toString(),
      'borrowUsageRatio': borrowUsageRatio.toString(),
      'supplyUsageRatio': supplyUsageRatio.toString(),
      'supplyAPY': supplyAPY.toString(),
      'variableBorrowAPY': variableBorrowAPY.toString(),
      'stableBorrowAPY': stableBorrowAPY.toString(),
      'unborrowedLiquidity': unborrowedLiquidity.toString(),
      'supplyAPR': supplyAPR.toString(),
      'variableBorrowAPR': variableBorrowAPR.toString(),
      'stableBorrowAPR': stableBorrowAPR.toString(),
      'isIsolated': isIsolated,
      'isolationModeTotalDebtUSD': isolationModeTotalDebtUSD.toString(),
      'availableDebtCeilingUSD': availableDebtCeilingUSD.toString(),
      'debtCeilingUSD': debtCeilingUSD.toString(),
      'totalScaledVariableDebt': totalScaledVariableDebt.toString(),
      'totalPrincipalStableDebt': totalPrincipalStableDebt.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

FormatReserveResponse formatEnhancedReserve(
    GetComputedReserveFieldsResponse response,
    AggregatedReserveData reserve,
    int currentTimestamp) {
  Decimal normalizeWithReserve(BigNumberValue n) =>
      normalize(n, reserve.decimals.toInt());

  final isIsolated = reserve.debtCeiling != BigInt.zero;
  final availableDebtCeilingUSD = isIsolated
      ? normalize(reserve.debtCeiling - reserve.isolationModeTotalDebt,
          reserve.debtCeilingDecimals.toInt())
      : Decimal.zero;

  return FormatReserveResponse(
    reserve: reserve,
    formattedBaseLTVasCollateral:
        normalize(reserve.baseLTVasCollateral, LTV_PRECISION),
    formattedReserveLiquidationThreshold:
        normalize(reserve.reserveLiquidationThreshold, 4),
    formattedReserveLiquidationBonus:
        normalize(reserve.reserveLiquidationBonus, 4),
    formattedEModeLtv: normalize(reserve.eModeLtv, LTV_PRECISION),
    formattedEModeLiquidationBonus: normalize(reserve.eModeLiquidationBonus, 4),
    formattedEModeLiquidationThreshold:
        normalize(reserve.eModeLiquidationBonus, 4),
    formattedAvailableLiquidity:
        normalizeWithReserve(reserve.availableLiquidity),
    totalDebt: normalizeWithReserve(response.totalDebt),
    totalVariableDebt: normalizeWithReserve(response.totalVariableDebt),
    totalStableDebt: normalizeWithReserve(response.totalStableDebt),
    totalLiquidity: normalizeWithReserve(response.totalLiquidity),
    borrowUsageRatio: response.borrowUsageRatio,
    supplyUsageRatio: response.supplyUsageRatio,
    supplyAPY: normalize(response.supplyAPY, RAY_DECIMALS),
    variableBorrowAPY: normalize(response.variableBorrowAPY, RAY_DECIMALS),
    stableBorrowAPY: normalize(response.stableBorrowAPY, RAY_DECIMALS),
    unborrowedLiquidity: normalizeWithReserve(response.unborrowedLiquidity),
    supplyAPR: normalize(reserve.liquidityRate, RAY_DECIMALS),
    variableBorrowAPR: normalize(reserve.variableBorrowRate, RAY_DECIMALS),
    stableBorrowAPR: normalize(reserve.stableBorrowRate, RAY_DECIMALS),
    isIsolated: isIsolated,
    isolationModeTotalDebtUSD: isIsolated
        ? normalize(
            reserve.isolationModeTotalDebt, reserve.debtCeilingDecimals.toInt())
        : Decimal.zero,
    availableDebtCeilingUSD: availableDebtCeilingUSD,
    totalPrincipalStableDebt:
        normalizeWithReserve(reserve.totalPrincipalStableDebt),
    totalScaledVariableDebt:
        normalizeWithReserve(reserve.totalScaledVariableDebt),
    debtCeilingUSD: isIsolated
        ? normalize(reserve.debtCeiling, reserve.debtCeilingDecimals.toInt())
        : Decimal.zero,
  );
}

FormatReserveResponse formatReserve(
    AggregatedReserveData reserve, int currentTimestamp) {
  final computedFields = getComputedReserveFields(reserve, currentTimestamp);
  return formatEnhancedReserve(computedFields, reserve, currentTimestamp);
}

class FormatReserveUSDResponse {
  FormatReserveResponse formatedRreserve;
  final Decimal totalLiquidityUSD;
  final Decimal availableLiquidityUSD;
  final Decimal totalDebtUSD;
  final Decimal totalVariableDebtUSD;
  final Decimal totalStableDebtUSD;
  final Decimal borrowCapUSD;
  final Decimal supplyCapUSD;
  final Decimal unbackedUSD;
  final Decimal priceInMarketReferenceCurrency;
  final Decimal formattedPriceInMarketReferenceCurrency;
  final Decimal priceInUSD;
  FormatReserveUSDResponse({
    required this.formatedRreserve,
    required this.totalLiquidityUSD,
    required this.availableLiquidityUSD,
    required this.totalDebtUSD,
    required this.totalVariableDebtUSD,
    required this.totalStableDebtUSD,
    required this.borrowCapUSD,
    required this.supplyCapUSD,
    required this.unbackedUSD,
    required this.priceInMarketReferenceCurrency,
    required this.formattedPriceInMarketReferenceCurrency,
    required this.priceInUSD,
  });

  Map<String, dynamic> toJson() {
    return {
      'formatedRreserve': formatedRreserve.toJson(),
      'totalLiquidityUSD': totalLiquidityUSD.toString(),
      'availableLiquidityUSD': availableLiquidityUSD.toString(),
      'totalDebtUSD': totalDebtUSD.toString(),
      'totalVariableDebtUSD': totalVariableDebtUSD.toString(),
      'totalStableDebtUSD': totalStableDebtUSD.toString(),
      'borrowCapUSD': borrowCapUSD.toString(),
      'supplyCapUSD': supplyCapUSD.toString(),
      'unbackedUSD': unbackedUSD.toString(),
      'priceInMarketReferenceCurrency':
          priceInMarketReferenceCurrency.toString(),
      'formattedPriceInMarketReferenceCurrency':
          formattedPriceInMarketReferenceCurrency.toString(),
      'priceInUSD': priceInUSD.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

FormatReserveUSDResponse formatReserveUSD(
    AggregatedReserveData reserve,
    currentTimestamp,
    marketReferencePriceInUsd,
    marketReferenceCurrencyDecimals) {
  final normalizedMarketReferencePriceInUsd = normalizeBN(
    marketReferencePriceInUsd,
    USD_DECIMALS,
  );

  final computedFields = getComputedReserveFields(reserve, currentTimestamp);
  final formattedReserve =
      formatEnhancedReserve(computedFields, reserve, currentTimestamp);

  return FormatReserveUSDResponse(
    formatedRreserve: formattedReserve,
    totalLiquidityUSD: nativeToUSD(
      NativeToUSD(
        amount: computedFields.totalLiquidity,
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
    availableLiquidityUSD: nativeToUSD(
      NativeToUSD(
        amount: computedFields.formattedAvailableLiquidity,
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
    totalDebtUSD: nativeToUSD(
      NativeToUSD(
        amount: computedFields.totalDebt,
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
    totalVariableDebtUSD: nativeToUSD(
      NativeToUSD(
        amount: computedFields.totalVariableDebt,
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
    totalStableDebtUSD: nativeToUSD(
      NativeToUSD(
        amount: computedFields.totalStableDebt,
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
    borrowCapUSD: normalizedToUsd(
      reserve.borrowCap.toDecimal(),
      reserve.priceInMarketReferenceCurrency.toDecimal(),
      marketReferenceCurrencyDecimals,
    ),
    supplyCapUSD: normalizedToUsd(
      reserve.supplyCap.toDecimal(),
      reserve.priceInMarketReferenceCurrency.toDecimal(),
      marketReferenceCurrencyDecimals,
    ),
    unbackedUSD: normalizedToUsd(
      reserve.unbacked.toDecimal(),
      reserve.priceInMarketReferenceCurrency.toDecimal(),
      marketReferenceCurrencyDecimals,
    ),
    priceInMarketReferenceCurrency:
        reserve.priceInMarketReferenceCurrency.toDecimal(),
    formattedPriceInMarketReferenceCurrency: normalize(
      reserve.priceInMarketReferenceCurrency,
      marketReferenceCurrencyDecimals,
    ),
    priceInUSD: nativeToUSD(
      NativeToUSD(
        amount: Decimal.one.shift(reserve.decimals.toInt()),
        currencyDecimals: reserve.decimals.toInt(),
        marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
        priceInMarketReferenceCurrency: reserve.priceInMarketReferenceCurrency,
        normalizedMarketReferencePriceInUsd:
            normalizedMarketReferencePriceInUsd,
      ),
    ),
  );
}
