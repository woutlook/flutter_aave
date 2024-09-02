import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:tlend_app/models/reserve.dart';
import 'package:tlend_app/math/reserve.dart';
import 'package:tlend_app/math/big.dart';
import 'package:tlend_app/math/const.dart';
import 'package:tlend_app/math/usd.dart';
import 'package:tlend_app/math/pool.dart';
import 'package:tlend_app/math/ray.dart';

class CombinedReserveData {
  final UserReserveData userReserve;
  final FormatReserveResponse reserve;

  CombinedReserveData({
    required this.userReserve,
    required this.reserve,
  });
}

class UserReserveSummaryResponse {
  CombinedReserveData userReserve;
  Decimal underlyingBalance;
  Decimal underlyingBalanceMarketReferenceCurrency;
  Decimal underlyingBalanceUSD;
  Decimal variableBorrows;
  Decimal variableBorrowsMarketReferenceCurrency;
  Decimal variableBorrowsUSD;
  Decimal stableBorrows;
  Decimal stableBorrowsMarketReferenceCurrency;
  Decimal stableBorrowsUSD;
  Decimal totalBorrows;
  Decimal totalBorrowsMarketReferenceCurrency;
  Decimal totalBorrowsUSD;

  UserReserveSummaryResponse({
    required this.userReserve,
    required this.underlyingBalance,
    required this.underlyingBalanceMarketReferenceCurrency,
    required this.underlyingBalanceUSD,
    required this.variableBorrows,
    required this.variableBorrowsMarketReferenceCurrency,
    required this.variableBorrowsUSD,
    required this.stableBorrows,
    required this.stableBorrowsMarketReferenceCurrency,
    required this.stableBorrowsUSD,
    required this.totalBorrows,
    required this.totalBorrowsMarketReferenceCurrency,
    required this.totalBorrowsUSD,
  });
}

class RawUserSummaryRequest {
  List<UserReserveSummaryResponse> userReserves;
  Decimal marketReferencePriceInUsd;
  int marketReferenceCurrencyDecimals;
  int userEmodeCategoryId;

  RawUserSummaryRequest({
    required this.userReserves,
    required this.marketReferencePriceInUsd,
    required this.marketReferenceCurrencyDecimals,
    required this.userEmodeCategoryId,
  });
}

class RawUserSummaryResponse {
  Decimal totalLiquidityUSD;
  Decimal totalCollateralUSD;
  Decimal totalBorrowsUSD;
  Decimal totalLiquidityMarketReferenceCurrency;
  Decimal totalCollateralMarketReferenceCurrency;
  Decimal totalBorrowsMarketReferenceCurrency;
  Decimal availableBorrowsMarketReferenceCurrency;
  Decimal availableBorrowsUSD;
  Decimal currentLoanToValue;
  Decimal currentLiquidationThreshold;
  Decimal healthFactor;
  bool isInIsolationMode;
  FormatReserveResponse? isolatedReserve;

  RawUserSummaryResponse({
    required this.totalLiquidityUSD,
    required this.totalCollateralUSD,
    required this.totalBorrowsUSD,
    required this.totalLiquidityMarketReferenceCurrency,
    required this.totalCollateralMarketReferenceCurrency,
    required this.totalBorrowsMarketReferenceCurrency,
    required this.availableBorrowsMarketReferenceCurrency,
    required this.availableBorrowsUSD,
    required this.currentLoanToValue,
    required this.currentLiquidationThreshold,
    required this.healthFactor,
    required this.isInIsolationMode,
    this.isolatedReserve,
  });
}

class UserReserveTotalsRequest {
  List<UserReserveSummaryResponse> userReserves;
  int userEmodeCategoryId;

  UserReserveTotalsRequest({
    required this.userReserves,
    required this.userEmodeCategoryId,
  });
}

class UserReserveTotalsResponse {
  Decimal totalLiquidityMarketReferenceCurrency;
  Decimal totalBorrowsMarketReferenceCurrency;
  Decimal totalCollateralMarketReferenceCurrency;
  Decimal currentLtv;
  Decimal currentLiquidationThreshold;
  bool isInIsolationMode;
  FormatReserveResponse? isolatedReserve;

  UserReserveTotalsResponse({
    required this.totalLiquidityMarketReferenceCurrency,
    required this.totalBorrowsMarketReferenceCurrency,
    required this.totalCollateralMarketReferenceCurrency,
    required this.currentLtv,
    required this.currentLiquidationThreshold,
    required this.isInIsolationMode,
    this.isolatedReserve,
  });
}

UserReserveTotalsResponse calculateUserReserveTotals(
    UserReserveTotalsRequest request) {
  var totalLiquidityMarketReferenceCurrency = BigInt.zero;
  var totalCollateralMarketReferenceCurrency = BigInt.zero;
  var totalBorrowsMarketReferenceCurrency = BigInt.zero;
  var currentLtv = BigInt.zero;
  var currentLiquidationThreshold = BigInt.zero;
  var isInIsolationMode = false;
  FormatReserveResponse? isolatedReserve;

  for (var userReserveSummary in request.userReserves) {
    totalLiquidityMarketReferenceCurrency +=
        userReserveSummary.underlyingBalanceMarketReferenceCurrency.toBigInt();
    totalBorrowsMarketReferenceCurrency +=
        userReserveSummary.variableBorrowsMarketReferenceCurrency.toBigInt() +
            userReserveSummary.stableBorrowsMarketReferenceCurrency.toBigInt();

    final formatedReserve = userReserveSummary.userReserve.reserve;

    if (formatedReserve.reserve.reserveLiquidationThreshold != BigInt.zero &&
        userReserveSummary
            .userReserve.userReserve.usageAsCollateralEnabledOnUser) {
      if (formatedReserve.reserve.debtCeiling != BigInt.zero) {
        isolatedReserve = userReserveSummary.userReserve.reserve;
        isInIsolationMode = true;
      }

      totalCollateralMarketReferenceCurrency += userReserveSummary
          .underlyingBalanceMarketReferenceCurrency
          .toBigInt();

      if (request.userEmodeCategoryId ==
          formatedReserve.reserve.eModeCategoryId.toInt()) {
        currentLtv += (userReserveSummary
                .underlyingBalanceMarketReferenceCurrency
                .toBigInt() *
            formatedReserve.reserve.eModeLtv);
        currentLiquidationThreshold += (userReserveSummary
                .underlyingBalanceMarketReferenceCurrency
                .toBigInt() *
            formatedReserve.reserve.eModeLiquidationThreshold);
      } else {
        currentLtv += (userReserveSummary
                .underlyingBalanceMarketReferenceCurrency
                .toBigInt() *
            formatedReserve.reserve.baseLTVasCollateral);
        currentLiquidationThreshold += (userReserveSummary
                .underlyingBalanceMarketReferenceCurrency
                .toBigInt() *
            formatedReserve.reserve.reserveLiquidationThreshold);
      }
    }
  }

  if (currentLtv > BigInt.zero) {
    currentLtv = (currentLtv ~/ totalCollateralMarketReferenceCurrency);
  }

  if (currentLiquidationThreshold > BigInt.zero) {
    currentLiquidationThreshold =
        (currentLiquidationThreshold ~/ totalCollateralMarketReferenceCurrency);
  }

  return UserReserveTotalsResponse(
    totalLiquidityMarketReferenceCurrency:
        totalLiquidityMarketReferenceCurrency.toDecimal(),
    totalBorrowsMarketReferenceCurrency:
        totalBorrowsMarketReferenceCurrency.toDecimal(),
    totalCollateralMarketReferenceCurrency:
        totalCollateralMarketReferenceCurrency.toDecimal(),
    currentLtv: currentLtv.toDecimal(),
    currentLiquidationThreshold: currentLiquidationThreshold.toDecimal(),
    isInIsolationMode: isInIsolationMode,
    isolatedReserve: isolatedReserve,
  );
}

class AvailableBorrowsMarketReferenceCurrencyRequest {
  Decimal collateralBalanceMarketReferenceCurrency;
  Decimal borrowBalanceMarketReferenceCurrency;
  Decimal currentLtv;

  AvailableBorrowsMarketReferenceCurrencyRequest({
    required this.collateralBalanceMarketReferenceCurrency,
    required this.borrowBalanceMarketReferenceCurrency,
    required this.currentLtv,
  });
}

// Decimal calculateAvailableBorrowsMarketReferenceCurrency(
//     AvailableBorrowsMarketReferenceCurrencyRequest request) {
//   if (request.currentLtv == Decimal.zero) {
//     return Decimal.zero;
//   }

//   var availableBorrowsMarketReferenceCurrency =
//       (request.collateralBalanceMarketReferenceCurrency * request.currentLtv)
//               .shift(LTV_PRECISION * -1) -
//           request.borrowBalanceMarketReferenceCurrency;
//   return availableBorrowsMarketReferenceCurrency > Decimal.zero
//       ? availableBorrowsMarketReferenceCurrency
//       : Decimal.zero;
// }

Decimal min(Decimal a, Decimal b) {
  return a < b ? a : b;
}

Decimal max(Decimal a, Decimal b) {
  return a > b ? a : b;
}

RawUserSummaryResponse generateRawUserSummary(RawUserSummaryRequest request) {
  final userReserveTotalsRequest = UserReserveTotalsRequest(
    userReserves: request.userReserves,
    userEmodeCategoryId: request.userEmodeCategoryId,
  );
  final totals = calculateUserReserveTotals(userReserveTotalsRequest);

  var availableBorrowsMarketReferenceCurrency0 =
      calculateAvailableBorrowsMarketReferenceCurrency(
          collateralBalanceMarketReferenceCurrency:
              totals.totalCollateralMarketReferenceCurrency.toBigInt(),
          borrowBalanceMarketReferenceCurrency:
              totals.totalBorrowsMarketReferenceCurrency.toBigInt(),
          currentLtv: totals.currentLtv.toBigInt());

  var availableBorrowsMarketReferenceCurrency =
      availableBorrowsMarketReferenceCurrency0;
  if (totals.isInIsolationMode && totals.isolatedReserve != null) {
    final v = normalizeBN(
      (totals.isolatedReserve!.reserve.debtCeiling -
          totals.isolatedReserve!.reserve.isolationModeTotalDebt),
      (totals.isolatedReserve!.reserve.debtCeilingDecimals.toInt() -
              request.marketReferenceCurrencyDecimals)
          .toInt(),
    );
    availableBorrowsMarketReferenceCurrency = min(
      max(Decimal.zero, v),
      availableBorrowsMarketReferenceCurrency0,
    );
  }

  return RawUserSummaryResponse(
    isInIsolationMode: totals.isInIsolationMode,
    isolatedReserve: totals.isolatedReserve,
    totalLiquidityUSD: normalizedToUsd(
      totals.totalLiquidityMarketReferenceCurrency,
      request.marketReferencePriceInUsd,
      request.marketReferenceCurrencyDecimals,
    ),
    totalCollateralUSD: normalizedToUsd(
      totals.totalCollateralMarketReferenceCurrency,
      request.marketReferencePriceInUsd,
      request.marketReferenceCurrencyDecimals,
    ),
    totalBorrowsUSD: normalizedToUsd(
      totals.totalBorrowsMarketReferenceCurrency,
      request.marketReferencePriceInUsd,
      request.marketReferenceCurrencyDecimals,
    ),
    totalLiquidityMarketReferenceCurrency:
        totals.totalLiquidityMarketReferenceCurrency,
    totalCollateralMarketReferenceCurrency:
        totals.totalCollateralMarketReferenceCurrency,
    totalBorrowsMarketReferenceCurrency:
        totals.totalBorrowsMarketReferenceCurrency,
    availableBorrowsMarketReferenceCurrency:
        availableBorrowsMarketReferenceCurrency,
    availableBorrowsUSD: normalizedToUsd(
      availableBorrowsMarketReferenceCurrency,
      request.marketReferencePriceInUsd,
      request.marketReferenceCurrencyDecimals,
    ),
    currentLoanToValue: totals.currentLtv,
    currentLiquidationThreshold: totals.currentLiquidationThreshold,
    healthFactor: calculateHealthFactorFromBalances(
        collateralBalanceMarketReferenceCurrency:
            totals.totalCollateralMarketReferenceCurrency,
        borrowBalanceMarketReferenceCurrency:
            totals.totalBorrowsMarketReferenceCurrency,
        currentLiquidationThreshold: totals.currentLiquidationThreshold),
  );
}

class ComputedUserReserve {
  Decimal underlyingBalance;
  Decimal underlyingBalanceMarketReferenceCurrency;
  Decimal underlyingBalanceUSD;
  Decimal variableBorrows;
  Decimal variableBorrowsMarketReferenceCurrency;
  Decimal variableBorrowsUSD;
  Decimal stableBorrows;
  Decimal stableBorrowsMarketReferenceCurrency;
  Decimal stableBorrowsUSD;
  Decimal totalBorrows;
  Decimal totalBorrowsMarketReferenceCurrency;
  Decimal totalBorrowsUSD;
  Decimal stableBorrowAPY;
  Decimal stableBorrowAPR;
  FormatReserveResponse reserve;
  UserReserveData userReserve;

  ComputedUserReserve({
    required this.underlyingBalance,
    required this.underlyingBalanceMarketReferenceCurrency,
    required this.underlyingBalanceUSD,
    required this.variableBorrows,
    required this.variableBorrowsMarketReferenceCurrency,
    required this.variableBorrowsUSD,
    required this.stableBorrows,
    required this.stableBorrowsMarketReferenceCurrency,
    required this.stableBorrowsUSD,
    required this.totalBorrows,
    required this.totalBorrowsMarketReferenceCurrency,
    required this.totalBorrowsUSD,
    required this.stableBorrowAPY,
    required this.stableBorrowAPR,
    required this.reserve,
    required this.userReserve,
  });

  Map<String, dynamic> toJson() {
    return {
      'underlyingBalance': underlyingBalance.toString(),
      'underlyingBalanceMarketReferenceCurrency':
          underlyingBalanceMarketReferenceCurrency.toString(),
      'underlyingBalanceUSD': underlyingBalanceUSD.toString(),
      'variableBorrows': variableBorrows.toString(),
      'variableBorrowsMarketReferenceCurrency':
          variableBorrowsMarketReferenceCurrency.toString(),
      'variableBorrowsUSD': variableBorrowsUSD.toString(),
      'stableBorrows': stableBorrows.toString(),
      'stableBorrowsMarketReferenceCurrency':
          stableBorrowsMarketReferenceCurrency.toString(),
      'stableBorrowsUSD': stableBorrowsUSD.toString(),
      'totalBorrows': totalBorrows.toString(),
      'totalBorrowsMarketReferenceCurrency':
          totalBorrowsMarketReferenceCurrency.toString(),
      'totalBorrowsUSD': totalBorrowsUSD.toString(),
      'stableBorrowAPY': stableBorrowAPY.toString(),
      'stableBorrowAPR': stableBorrowAPR.toString(),
      'reserve': reserve.toJson(),
      'userReserve': userReserve.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class UserReserveSummaryRequest {
  CombinedReserveData userReserve;
  Decimal marketReferencePriceInUsdNormalized;
  int marketReferenceCurrencyDecimals;
  int currentTimestamp;

  UserReserveSummaryRequest({
    required this.userReserve,
    required this.marketReferencePriceInUsdNormalized,
    required this.marketReferenceCurrencyDecimals,
    required this.currentTimestamp,
  });
}

UserReserveSummaryResponse generateUserReserveSummary(
    UserReserveSummaryRequest request) {
  var poolReserve = request.userReserve.reserve.reserve;
  var priceInMarketReferenceCurrency =
      poolReserve.priceInMarketReferenceCurrency;
  var decimals = poolReserve.decimals;

  var underlyingBalance = getLinearBalance(
    balance: request.userReserve.userReserve.scaledATokenBalance,
    index: poolReserve.liquidityIndex,
    rate: poolReserve.liquidityRate,
    lastUpdateTimestamp: poolReserve.lastUpdateTimestamp,
    currentTimestamp: BigInt.from(request.currentTimestamp),
  );

  var underlyingBalanceMarketReferenceCurrencyAndUSD =
      getMarketReferenceCurrencyAndUsdBalance(
    balance: underlyingBalance,
    priceInMarketReferenceCurrency: priceInMarketReferenceCurrency,
    marketReferenceCurrencyDecimals: request.marketReferenceCurrencyDecimals,
    decimals: decimals.toInt(),
    marketReferencePriceInUsdNormalized:
        request.marketReferencePriceInUsdNormalized.toBigInt(),
  );

  var variableBorrows = getCompoundedBalance(
    principalBalance: request.userReserve.userReserve.scaledVariableDebt,
    reserveIndex: poolReserve.variableBorrowIndex,
    reserveRate: poolReserve.variableBorrowRate,
    lastUpdateTimestamp: poolReserve.lastUpdateTimestamp.toInt(),
    currentTimestamp: request.currentTimestamp,
  );

  var variableBorrowsMarketReferenceCurrencyAndUSD =
      getMarketReferenceCurrencyAndUsdBalance(
    balance: variableBorrows,
    priceInMarketReferenceCurrency: priceInMarketReferenceCurrency,
    marketReferenceCurrencyDecimals: request.marketReferenceCurrencyDecimals,
    decimals: decimals.toInt(),
    marketReferencePriceInUsdNormalized:
        request.marketReferencePriceInUsdNormalized.toBigInt(),
  );

  var stableBorrows = getCompoundedStableBalance(
      principalBalance: request.userReserve.userReserve.principalStableDebt,
      userStableRate: request.userReserve.userReserve.stableBorrowRate,
      lastUpdateTimestamp: request
          .userReserve.userReserve.stableBorrowLastUpdateTimestamp
          .toInt(),
      currentTimestamp: request.currentTimestamp);

  var stableBorrowsMarketReferenceCurrencyAndUSD =
      getMarketReferenceCurrencyAndUsdBalance(
    balance: stableBorrows,
    priceInMarketReferenceCurrency: priceInMarketReferenceCurrency,
    marketReferenceCurrencyDecimals: request.marketReferenceCurrencyDecimals,
    decimals: decimals.toInt(),
    marketReferencePriceInUsdNormalized:
        request.marketReferencePriceInUsdNormalized.toBigInt(),
  );

  return UserReserveSummaryResponse(
    userReserve: request.userReserve,
    underlyingBalance: underlyingBalance.toDecimal(),
    underlyingBalanceMarketReferenceCurrency:
        underlyingBalanceMarketReferenceCurrencyAndUSD
            .marketReferenceCurrencyBalance,
    underlyingBalanceUSD:
        underlyingBalanceMarketReferenceCurrencyAndUSD.usdBalance,
    variableBorrows: variableBorrows.toDecimal(),
    variableBorrowsMarketReferenceCurrency:
        variableBorrowsMarketReferenceCurrencyAndUSD
            .marketReferenceCurrencyBalance,
    variableBorrowsUSD: variableBorrowsMarketReferenceCurrencyAndUSD.usdBalance,
    stableBorrows: stableBorrows.toDecimal(),
    stableBorrowsMarketReferenceCurrency:
        stableBorrowsMarketReferenceCurrencyAndUSD
            .marketReferenceCurrencyBalance,
    stableBorrowsUSD: stableBorrowsMarketReferenceCurrencyAndUSD.usdBalance,
    totalBorrows: (variableBorrows + stableBorrows).toDecimal(),
    totalBorrowsMarketReferenceCurrency:
        (variableBorrowsMarketReferenceCurrencyAndUSD
                .marketReferenceCurrencyBalance +
            stableBorrowsMarketReferenceCurrencyAndUSD
                .marketReferenceCurrencyBalance),
    totalBorrowsUSD: (variableBorrowsMarketReferenceCurrencyAndUSD.usdBalance +
        stableBorrowsMarketReferenceCurrencyAndUSD.usdBalance),
  );
}

class FormatUserReserveRequest {
  UserReserveSummaryResponse reserve;
  int marketReferenceCurrencyDecimals;

  FormatUserReserveRequest({
    required this.reserve,
    required this.marketReferenceCurrencyDecimals,
  });
}

ComputedUserReserve formatUserReserve(FormatUserReserveRequest request) {
  var userReserve = request.reserve.userReserve;
  var reserve = userReserve.reserve.reserve;
  var reserveDecimals = reserve.decimals.toInt();

  Decimal normalizeWithReserve(Decimal n) => normalize(n, reserveDecimals);

  var exactStableBorrowRate = rayPow(
          userReserve.userReserve.stableBorrowRate ~/ SECONDS_PER_YEAR + RAY,
          SECONDS_PER_YEAR) -
      RAY;

  return ComputedUserReserve(
      underlyingBalance:
          normalize(request.reserve.underlyingBalance, reserveDecimals),
      underlyingBalanceMarketReferenceCurrency: normalize(
        request.reserve.underlyingBalanceMarketReferenceCurrency,
        request.marketReferenceCurrencyDecimals,
      ),
      underlyingBalanceUSD: request.reserve.underlyingBalanceUSD,
      stableBorrows: normalizeWithReserve(request.reserve.stableBorrows),
      stableBorrowsMarketReferenceCurrency: normalize(
        request.reserve.stableBorrowsMarketReferenceCurrency,
        request.marketReferenceCurrencyDecimals,
      ),
      stableBorrowsUSD: request.reserve.stableBorrowsUSD,
      variableBorrows: normalizeWithReserve(request.reserve.variableBorrows),
      variableBorrowsMarketReferenceCurrency: normalize(
        request.reserve.variableBorrowsMarketReferenceCurrency,
        request.marketReferenceCurrencyDecimals,
      ),
      variableBorrowsUSD: request.reserve.variableBorrowsUSD,
      totalBorrows: normalizeWithReserve(request.reserve.totalBorrows),
      totalBorrowsMarketReferenceCurrency: normalize(
        request.reserve.totalBorrowsMarketReferenceCurrency,
        request.marketReferenceCurrencyDecimals,
      ),
      totalBorrowsUSD: request.reserve.totalBorrowsUSD,
      stableBorrowAPR:
          normalize(userReserve.userReserve.stableBorrowRate, RAY_DECIMALS),
      stableBorrowAPY: normalize(exactStableBorrowRate, RAY_DECIMALS),
      reserve: userReserve.reserve,
      userReserve: userReserve.userReserve);
}

class FormatUserSummaryRequest {
  List<UserReserveData> userReserves;
  List<FormatReserveResponse> reserves;
  BigInt marketReferencePriceInUsd;
  int marketReferenceCurrencyDecimals;
  int currentTimestamp;
  int userEmodeCategoryId;

  FormatUserSummaryRequest({
    required this.userReserves,
    required this.reserves,
    required this.marketReferencePriceInUsd,
    required this.marketReferenceCurrencyDecimals,
    required this.currentTimestamp,
    required this.userEmodeCategoryId,
  });
}

class FormatUserSummaryResponse {
  List<ComputedUserReserve> userReserves;
  Decimal totalLiquidityMarketReferenceCurrency;
  Decimal totalLiquidityUSD;
  Decimal totalCollateralMarketReferenceCurrency;
  Decimal totalCollateralUSD;
  Decimal totalBorrowsMarketReferenceCurrency;
  Decimal totalBorrowsUSD;
  Decimal netWorthUSD;
  Decimal availableBorrowsMarketReferenceCurrency;
  Decimal availableBorrowsUSD;
  Decimal currentLoanToValue;
  Decimal currentLiquidationThreshold;
  Decimal healthFactor;
  int userEmodeCategoryId;
  bool isInIsolationMode;
  FormatReserveResponse? isolatedReserve;

  FormatUserSummaryResponse({
    required this.userReserves,
    required this.totalLiquidityMarketReferenceCurrency,
    required this.totalLiquidityUSD,
    required this.totalCollateralMarketReferenceCurrency,
    required this.totalCollateralUSD,
    required this.totalBorrowsMarketReferenceCurrency,
    required this.totalBorrowsUSD,
    required this.netWorthUSD,
    required this.availableBorrowsMarketReferenceCurrency,
    required this.availableBorrowsUSD,
    required this.currentLoanToValue,
    required this.currentLiquidationThreshold,
    required this.healthFactor,
    required this.userEmodeCategoryId,
    required this.isInIsolationMode,
    this.isolatedReserve,
  });

  Map<String, dynamic> toJson() {
    return {
      'userReserves': userReserves.map((r) => r.toJson()).toList(),
      'totalLiquidityMarketReferenceCurrency':
          totalLiquidityMarketReferenceCurrency.toString(),
      'totalLiquidityUSD': totalLiquidityUSD.toString(),
      'totalCollateralMarketReferenceCurrency':
          totalCollateralMarketReferenceCurrency.toString(),
      'totalCollateralUSD': totalCollateralUSD.toString(),
      'totalBorrowsMarketReferenceCurrency':
          totalBorrowsMarketReferenceCurrency.toString(),
      'totalBorrowsUSD': totalBorrowsUSD.toString(),
      'netWorthUSD': netWorthUSD.toString(),
      'availableBorrowsMarketReferenceCurrency':
          availableBorrowsMarketReferenceCurrency.toString(),
      'availableBorrowsUSD': availableBorrowsUSD.toString(),
      'currentLoanToValue': currentLoanToValue.toString(),
      'currentLiquidationThreshold': currentLiquidationThreshold.toString(),
      'healthFactor': healthFactor.toString(),
      'userEmodeCategoryId': userEmodeCategoryId,
      'isInIsolationMode': isInIsolationMode,
      'isolatedReserve': isolatedReserve?.toJson(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

FormatUserSummaryResponse formatUserSummary(FormatUserSummaryRequest request) {
  final normalizedMarketRefPriceInUsd = normalize(
    request.marketReferencePriceInUsd,
    USD_DECIMALS,
  );

  // Combine raw user and formatted reserve data
  final combinedReserves = <CombinedReserveData>[];

  for (var userReserve in request.userReserves) {
    final reserve = request.reserves.firstWhereOrNull((r) =>
        r.reserve.underlyingAsset.toString().toLowerCase() ==
        userReserve.underlyingAsset.toString().toLowerCase());

    if (reserve == null) {
      continue;
    }
    combinedReserves.add(CombinedReserveData(
      userReserve: userReserve,
      reserve: reserve,
    ));
  }

  final computedUserReserves = combinedReserves
      .map((userReserve) =>
          generateUserReserveSummary(UserReserveSummaryRequest(
            userReserve: userReserve,
            marketReferencePriceInUsdNormalized: normalizedMarketRefPriceInUsd,
            marketReferenceCurrencyDecimals:
                request.marketReferenceCurrencyDecimals,
            currentTimestamp: request.currentTimestamp,
          )))
      .toList();

  final formattedUserReserves = computedUserReserves
      .map((computedUserReserve) => formatUserReserve(FormatUserReserveRequest(
          reserve: computedUserReserve,
          marketReferenceCurrencyDecimals:
              request.marketReferenceCurrencyDecimals)))
      .toList();

  final rawRequest = RawUserSummaryRequest(
    userReserves: computedUserReserves,
    marketReferencePriceInUsd: normalizedMarketRefPriceInUsd,
    marketReferenceCurrencyDecimals: request.marketReferenceCurrencyDecimals,
    userEmodeCategoryId: request.userEmodeCategoryId,
  );

  final userData = generateRawUserSummary(rawRequest);

  return FormatUserSummaryResponse(
    userReserves: formattedUserReserves,
    totalLiquidityMarketReferenceCurrency: normalize(
      userData.totalLiquidityMarketReferenceCurrency,
      request.marketReferenceCurrencyDecimals,
    ),
    totalLiquidityUSD: userData.totalLiquidityUSD,
    totalCollateralMarketReferenceCurrency: normalize(
      userData.totalCollateralMarketReferenceCurrency,
      request.marketReferenceCurrencyDecimals,
    ),
    totalCollateralUSD: userData.totalCollateralUSD,
    totalBorrowsMarketReferenceCurrency: normalize(
      userData.totalBorrowsMarketReferenceCurrency,
      request.marketReferenceCurrencyDecimals,
    ),
    totalBorrowsUSD: userData.totalBorrowsUSD,
    netWorthUSD: (userData.totalLiquidityUSD - userData.totalBorrowsUSD),
    availableBorrowsMarketReferenceCurrency: normalize(
      userData.availableBorrowsMarketReferenceCurrency,
      request.marketReferenceCurrencyDecimals,
    ),
    availableBorrowsUSD: userData.availableBorrowsUSD,
    currentLoanToValue: normalize(userData.currentLoanToValue, LTV_PRECISION),
    currentLiquidationThreshold: normalize(
      userData.currentLiquidationThreshold,
      LTV_PRECISION,
    ),
    healthFactor: userData.healthFactor,
    userEmodeCategoryId: request.userEmodeCategoryId,
    isInIsolationMode: userData.isInIsolationMode,
    isolatedReserve: userData.isolatedReserve,
  );
}
