import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tlend_app/math/const.dart';
import 'package:tlend_app/providers/reserve.dart';
import 'package:tlend_app/providers/incentive.dart';
import 'package:tlend_app/providers/balance.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/math/reserve.dart';
import 'package:tlend_app/math/incentive.dart';
import 'package:tlend_app/math/user.dart';
import 'package:tlend_app/config/tokens.dart';
import 'package:tlend_app/models/appdata.dart';

final appDataProvider = FutureProvider<AppData>((ref) async {
  final reservesData = await ref.watch(reservesDataProvider.future);
  final incentivesData = await ref.watch(incentivesProvider.future);
  final userReservesData = await ref.watch(userReservesDataProvider.future);
  final userIncentivesData = await ref.watch(userIncentivesProvider.future);
  final userBalances = await ref.watch(userBalanceProvider.future);
  // bool isTestnet = ref.watch(testNetworkProvider);
  int chainId = ref.watch(networkProvider);
  if (chainId == 11155111) {
    chainId = 1;
  }

  final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final marketReferencePriceInUsd =
      reservesData.baseCurrencyInfo.marketReferenceCurrencyPriceInUsd;
  final marketReferenceCurrencyDecimals = reservesData
          .baseCurrencyInfo.marketReferenceCurrencyUnit
          .toString()
          .length -
      1;

  final activeReserves = reservesData.reserves.where((reserve) {
    return reserve.isActive && !reserve.isFrozen;
  });
  final reserves = activeReserves
      .map((reserve) => formatReserveUSD(reserve, currentTimestamp,
          marketReferencePriceInUsd, marketReferenceCurrencyDecimals))
      .toList();

  final tokens = {
    for (var reserve in reserves)
      reserve.formatedRreserve.reserve.underlyingAsset.toString(): TokenList()
          .getToken(chainId.toString(), reserve.formatedRreserve.reserve.symbol)
  };

  final formatedReserves =
      reserves.map((reserve) => reserve.formatedRreserve).toList();

  final balances = reserves.map((e) {
    final reserve = e.formatedRreserve.reserve;
    final address = reserve.underlyingAsset.toString();
    final amount = userBalances[address] ?? BigInt.zero;

    final d = reserve.decimals.toInt();
    final balance = amount.toDecimal().shift(-d);

    final dd = d + marketReferenceCurrencyDecimals;
    final usdBalance =
        ((amount * reserve.priceInMarketReferenceCurrency).toDecimal() *
                marketReferencePriceInUsd.toDecimal().shift(-USD_DECIMALS))
            .shift(-dd);

    return WalletBalance(
        symbol: reserve.symbol, balance: balance, balanceUSD: usdBalance);
  }).toList();

  final balanceMap = {for (var b in balances) b.symbol: b};

  final userReservesRequest = FormatUserSummaryRequest(
      userReserves: userReservesData.reserves,
      reserves: formatedReserves,
      marketReferencePriceInUsd: marketReferencePriceInUsd,
      marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
      currentTimestamp: currentTimestamp,
      userEmodeCategoryId: userReservesData.userEmodeCategoryId.toInt());

  final userReserves = formatUserSummary(userReservesRequest);

  final calulatedReserves = reserves.map((e) {
    final reserve = e.formatedRreserve;
    return ReserveCalculationData(
        underlyingAsset: reserve.reserve.underlyingAsset.toString(),
        symbol: reserve.reserve.symbol,
        decimals: reserve.reserve.decimals.toInt(),
        totalLiquidity: reserve.totalLiquidity,
        totalVariableDebt: reserve.totalVariableDebt,
        totalStableDebt: reserve.totalStableDebt,
        formattedPriceInMarketReferenceCurrency:
            e.formattedPriceInMarketReferenceCurrency);
  }).toList();

  final incentives = calculateAllReserveIncentives(
      CalculateAllReserveIncentivesRequest(
          reserveIncentives: incentivesData,
          reserves: calulatedReserves,
          marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals));

  final calculatedUserReserves = userReserves.userReserves
      .map((userReserve) => UserReserveCalculationData(
          decimals: userReserve.reserve.reserve.decimals.toInt(),
          underlyingAsset: userReserve.userReserve.underlyingAsset.toString(),
          scaledATokenBalance:
              userReserve.userReserve.scaledATokenBalance.toDecimal(),
          scaledVariableDebt:
              userReserve.userReserve.scaledVariableDebt.toDecimal(),
          principalStableDebt:
              userReserve.userReserve.principalStableDebt.toDecimal(),
          totalLiquidity: userReserve.reserve.totalLiquidity,
          liquidityIndex:
              userReserve.reserve.reserve.liquidityIndex.toDecimal(),
          totalPrincipalStableDebt:
              userReserve.reserve.totalPrincipalStableDebt,
          totalScaledVariableDebt: userReserve.reserve.totalScaledVariableDebt))
      .toList();

  final userIncentives = calculateAllUserIncentives(
      CalculateAllUserIncentivesRequest(
          reserveIncentives: incentivesData,
          userIncentives: userIncentivesData,
          userReserves: calculatedUserReserves,
          currentTimestamp: currentTimestamp));

  appDataCache = AppData(
    reserves: reserves,
    incentives: incentives,
    userReserves: userReserves,
    userIncentives: userIncentives,
    userBalances: balanceMap,
    tokens: tokens,
    marketReferencePriceInUsd: marketReferencePriceInUsd,
    marketReferenceCurrencyDecimals: marketReferenceCurrencyDecimals,
    // isTestnet: isTestnet,
  );
  return appDataCache!;
});

AppData? appDataCache;
