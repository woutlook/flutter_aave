import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:tlend_app/models/incentive.dart';
import 'package:tlend_app/math/big.dart';
import 'package:tlend_app/math/ray.dart';
import 'package:tlend_app/math/const.dart';

class UserReserveCalculationData {
  Decimal scaledATokenBalance;
  Decimal scaledVariableDebt;
  Decimal principalStableDebt;
  String underlyingAsset;
  Decimal totalLiquidity;
  Decimal liquidityIndex;
  Decimal totalScaledVariableDebt;
  Decimal totalPrincipalStableDebt;
  int decimals;

  UserReserveCalculationData({
    required this.scaledATokenBalance,
    required this.scaledVariableDebt,
    required this.principalStableDebt,
    required this.underlyingAsset,
    required this.totalLiquidity,
    required this.liquidityIndex,
    required this.totalScaledVariableDebt,
    required this.totalPrincipalStableDebt,
    required this.decimals,
  });
}

class Reserve {
  String underlyingAsset;
  Decimal formattedPriceInMarketReferenceCurrency;

  Reserve({
    required this.underlyingAsset,
    required this.formattedPriceInMarketReferenceCurrency,
  });
}

class ReserveCalculationData {
  String underlyingAsset;
  String symbol;
  Decimal totalLiquidity;
  Decimal totalVariableDebt;
  Decimal totalStableDebt;
  Decimal formattedPriceInMarketReferenceCurrency;
  int decimals;

  ReserveCalculationData({
    required this.underlyingAsset,
    required this.symbol,
    required this.totalLiquidity,
    required this.totalVariableDebt,
    required this.totalStableDebt,
    required this.formattedPriceInMarketReferenceCurrency,
    required this.decimals,
  });
}

class ReserveIncentiveResponse {
  Decimal incentiveAPR;
  String rewardTokenAddress;
  String rewardTokenSymbol;

  ReserveIncentiveResponse({
    required this.incentiveAPR,
    required this.rewardTokenAddress,
    required this.rewardTokenSymbol,
  });

  Map<String, dynamic> toJson() {
    return {
      'incentiveAPR': incentiveAPR.toString(),
      'rewardTokenAddress': rewardTokenAddress,
      'rewardTokenSymbol': rewardTokenSymbol,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class CalculateReserveIncentivesResponse {
  String underlyingAsset;
  List<ReserveIncentiveResponse> aIncentivesData;
  List<ReserveIncentiveResponse> vIncentivesData;
  List<ReserveIncentiveResponse> sIncentivesData;

  CalculateReserveIncentivesResponse({
    required this.underlyingAsset,
    required this.aIncentivesData,
    required this.vIncentivesData,
    required this.sIncentivesData,
  });

  Map<String, dynamic> toJson() {
    return {
      'underlyingAsset': underlyingAsset,
      'aIncentivesData':
          aIncentivesData.map((incentive) => incentive.toJson()).toList(),
      'vIncentivesData':
          vIncentivesData.map((incentive) => incentive.toJson()).toList(),
      'sIncentivesData':
          sIncentivesData.map((incentive) => incentive.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class CalculateAccruedIncentivesRequest {
  final Decimal principalUserBalance;
  final Decimal reserveIndex;
  final Decimal userIndex;
  final int precision;
  final int reserveIndexTimestamp;
  final Decimal emissionPerSecond;
  final Decimal totalSupply;
  final int currentTimestamp;
  final int emissionEndTimestamp;

  CalculateAccruedIncentivesRequest({
    required this.principalUserBalance,
    required this.reserveIndex,
    required this.userIndex,
    required this.precision,
    required this.reserveIndexTimestamp,
    required this.emissionPerSecond,
    required this.totalSupply,
    required this.currentTimestamp,
    required this.emissionEndTimestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'principalUserBalance': principalUserBalance.toString(),
      'reserveIndex': reserveIndex.toString(),
      'userIndex': userIndex.toString(),
      'precision': precision,
      'reserveIndexTimestamp': reserveIndexTimestamp,
      'emissionPerSecond': emissionPerSecond.toString(),
      'totalSupply': totalSupply.toString(),
      'currentTimestamp': currentTimestamp,
      'emissionEndTimestamp': emissionEndTimestamp,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

Decimal calculateAccruedIncentives(CalculateAccruedIncentivesRequest request) {
  if (request.totalSupply == Decimal.zero) {
    return Decimal.zero;
  }

  int actualCurrentTimestamp =
      request.currentTimestamp > request.emissionEndTimestamp
          ? request.emissionEndTimestamp
          : request.currentTimestamp;

  int timeDelta = actualCurrentTimestamp - request.reserveIndexTimestamp;

  Decimal currentReserveIndex;
  if (request.reserveIndexTimestamp >= request.currentTimestamp ||
      request.reserveIndexTimestamp >= request.emissionEndTimestamp) {
    currentReserveIndex = request.reserveIndex;
  } else {
    currentReserveIndex = request.emissionPerSecond *
            (Decimal.fromInt(timeDelta).shift(request.precision) /
                    request.totalSupply)
                .toDecimal() +
        request.reserveIndex;
  }

  Decimal reward = request.principalUserBalance *
      (currentReserveIndex - request.userIndex).shift(-request.precision);

  return reward;
}

class FormatedUserIncentiveData {
  String incentiveControllerAddress;
  String rewardTokenSymbol;
  Decimal rewardPriceFeed;
  int rewardTokenDecimals;
  Decimal claimableRewards;
  List<String> assets;

  FormatedUserIncentiveData({
    required this.incentiveControllerAddress,
    required this.rewardTokenSymbol,
    required this.rewardPriceFeed,
    required this.rewardTokenDecimals,
    required this.claimableRewards,
    required this.assets,
  });

  Map<String, dynamic> toJson() {
    return {
      'incentiveControllerAddress': incentiveControllerAddress,
      'rewardTokenSymbol': rewardTokenSymbol,
      'rewardPriceFeed': rewardPriceFeed.toString(),
      'rewardTokenDecimals': rewardTokenDecimals,
      'claimableRewards': claimableRewards.toString(),
      'assets': assets,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class CalculateAllUserIncentivesRequest {
//  final List<AggregatedReserveData> reserves;
  final List<AggregatedReserveIncentiveData> reserveIncentives;
  final List<UserReserveIncentiveData> userIncentives;
  final List<UserReserveCalculationData> userReserves;
  final int currentTimestamp;

  CalculateAllUserIncentivesRequest({
    // required this.reserves,
    required this.reserveIncentives,
    required this.userIncentives,
    required this.userReserves,
    required this.currentTimestamp,
  });
}

class CalculateUserReserveIncentivesRequest {
  // final AggregatedReserveData reserve;
  final AggregatedReserveIncentiveData reserveIncentives;
  final UserReserveIncentiveData userIncentives;
  UserReserveCalculationData? userReserve;
  final int currentTimestamp;

  CalculateUserReserveIncentivesRequest({
    // required this.reserve,
    required this.reserveIncentives,
    required this.userIncentives,
    required this.currentTimestamp,
    this.userReserve,
  });
}

class UserReserveIncentive {
  final String tokenAddress;
  final String incentiveController;
  final String rewardTokenAddress;
  final String rewardTokenSymbol;
  final int rewardTokenDecimals;
  final Decimal accruedRewards;
  final Decimal unclaimedRewards;
  final Decimal rewardPriceFeed;

  UserReserveIncentive({
    required this.tokenAddress,
    required this.incentiveController,
    required this.rewardTokenAddress,
    required this.rewardTokenSymbol,
    required this.rewardTokenDecimals,
    required this.accruedRewards,
    required this.unclaimedRewards,
    required this.rewardPriceFeed,
  });

  Map<String, dynamic> toJson() {
    return {
      'tokenAddress': tokenAddress,
      'incentiveController': incentiveController,
      'rewardTokenAddress': rewardTokenAddress,
      'rewardTokenSymbol': rewardTokenSymbol,
      'rewardTokenDecimals': rewardTokenDecimals,
      'accruedRewards': accruedRewards.toString(),
      'unclaimedRewards': unclaimedRewards.toString(),
      'rewardPriceFeed': rewardPriceFeed.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

List<UserReserveIncentive> calculateUserReserveIncentives(
    CalculateUserReserveIncentivesRequest request) {
  List<UserReserveIncentive> calculatedUserIncentives = [];

  // Compute incentive data for each reward linked to supply of this reserve
  for (var userReserveIncentive in request
      .userIncentives.aTokenIncentivesUserData.userRewardsInformation) {
    final reserveIncentive = request
        .reserveIncentives.aIncentiveData.rewardsTokenInformation
        .firstWhereOrNull((reward) =>
            reward.rewardTokenAddress ==
            userReserveIncentive.rewardTokenAddress);

    if (reserveIncentive != null) {
      // Calculating accrued rewards is only required if user has an active aToken balance
      var accruedRewards = request.userReserve != null
          ? calculateAccruedIncentives(CalculateAccruedIncentivesRequest(
              principalUserBalance: request.userReserve!.scaledATokenBalance,
              reserveIndex: reserveIncentive.tokenIncentivesIndex.toDecimal(),
              userIndex:
                  userReserveIncentive.tokenIncentivesUserIndex.toDecimal(),
              precision: reserveIncentive.precision.toInt(),
              reserveIndexTimestamp:
                  reserveIncentive.incentivesLastUpdateTimestamp.toInt(),
              emissionPerSecond:
                  Decimal.fromBigInt(reserveIncentive.emissionPerSecond),
              totalSupply: rayDiv(
                      request.userReserve!.totalLiquidity
                          .shift(request.userReserve!.decimals.toInt())
                          .toBigInt(),
                      request.userReserve!.liquidityIndex.toBigInt())
                  .toDecimal(),
              currentTimestamp: request.currentTimestamp,
              emissionEndTimestamp:
                  reserveIncentive.emissionEndTimestamp.toInt()))
          : Decimal.zero;

      calculatedUserIncentives.add(
        UserReserveIncentive(
          tokenAddress: request
              .userIncentives.aTokenIncentivesUserData.tokenAddress
              .toString(),
          incentiveController: request.userIncentives.aTokenIncentivesUserData
              .incentiveControllerAddress
              .toString(),
          rewardTokenAddress:
              userReserveIncentive.rewardTokenAddress.toString(),
          rewardTokenDecimals: userReserveIncentive.rewardTokenDecimals.toInt(),
          accruedRewards: accruedRewards,
          unclaimedRewards:
              userReserveIncentive.userUnclaimedRewards.toDecimal(),
          rewardPriceFeed: normalize(
            userReserveIncentive.rewardPriceFeed,
            userReserveIncentive.priceFeedDecimals.toInt(),
          ),
          rewardTokenSymbol: userReserveIncentive.rewardTokenSymbol,
        ),
      );
    }
  }

  // Compute incentive data for each reward linked to variable borrows of this reserve
  for (var userReserveIncentive in request
      .userIncentives.vTokenIncentivesUserData.userRewardsInformation) {
    var reserveIncentive = request
        .reserveIncentives.vIncentiveData.rewardsTokenInformation
        .firstWhereOrNull((reward) =>
            reward.rewardTokenAddress ==
            userReserveIncentive.rewardTokenAddress);
    if (reserveIncentive != null) {
      // Calculating accrued rewards is only required if user has an active variableDebt token balance
      var accruedRewards = request.userReserve != null
          ? calculateAccruedIncentives(CalculateAccruedIncentivesRequest(
              principalUserBalance: request.userReserve!.scaledVariableDebt,
              reserveIndex: reserveIncentive.tokenIncentivesIndex.toDecimal(),
              userIndex:
                  userReserveIncentive.tokenIncentivesUserIndex.toDecimal(),
              precision: reserveIncentive.precision.toInt(),
              reserveIndexTimestamp:
                  reserveIncentive.incentivesLastUpdateTimestamp.toInt(),
              emissionPerSecond: reserveIncentive.emissionPerSecond.toDecimal(),
              totalSupply: request.userReserve!.totalScaledVariableDebt
                  .shift(request.userReserve!.decimals),
              currentTimestamp: request.currentTimestamp,
              emissionEndTimestamp:
                  reserveIncentive.emissionEndTimestamp.toInt()))
          : Decimal.zero;

      calculatedUserIncentives.add(
        UserReserveIncentive(
          tokenAddress: request
              .userIncentives.vTokenIncentivesUserData.tokenAddress
              .toString(),
          incentiveController: request.userIncentives.vTokenIncentivesUserData
              .incentiveControllerAddress
              .toString(),
          rewardTokenAddress:
              userReserveIncentive.rewardTokenAddress.toString(),
          rewardTokenDecimals: userReserveIncentive.rewardTokenDecimals.toInt(),
          accruedRewards: accruedRewards,
          unclaimedRewards:
              userReserveIncentive.userUnclaimedRewards.toDecimal(),
          rewardPriceFeed: normalize(
            userReserveIncentive.rewardPriceFeed,
            userReserveIncentive.priceFeedDecimals.toInt(),
          ),
          rewardTokenSymbol: userReserveIncentive.rewardTokenSymbol,
        ),
      );
    }
  }

  // Compute incentive data for each reward linked to stable borrows of this reserve
  for (var userReserveIncentive in request
      .userIncentives.sTokenIncentivesUserData.userRewardsInformation) {
    var reserveIncentive = request
        .reserveIncentives.sIncentiveData.rewardsTokenInformation
        .firstWhereOrNull((reward) =>
            reward.rewardTokenAddress ==
            userReserveIncentive.rewardTokenAddress);
    if (reserveIncentive != null) {
      // Calculating accrued rewards is only required if user has an active stableDebtToken balance
      var accruedRewards = request.userReserve != null
          ? calculateAccruedIncentives(CalculateAccruedIncentivesRequest(
              principalUserBalance: request.userReserve!.principalStableDebt,
              reserveIndex: reserveIncentive.tokenIncentivesIndex.toDecimal(),
              userIndex:
                  userReserveIncentive.tokenIncentivesUserIndex.toDecimal(),
              precision: reserveIncentive.precision.toInt(),
              reserveIndexTimestamp:
                  reserveIncentive.incentivesLastUpdateTimestamp.toInt(),
              emissionPerSecond: reserveIncentive.emissionPerSecond.toDecimal(),
              totalSupply: request.userReserve!.totalPrincipalStableDebt
                  .shift(request.userReserve!.decimals),
              currentTimestamp: request.currentTimestamp,
              emissionEndTimestamp:
                  reserveIncentive.emissionEndTimestamp.toInt()))
          : Decimal.zero;

      calculatedUserIncentives.add(
        UserReserveIncentive(
          tokenAddress: request
              .userIncentives.sTokenIncentivesUserData.tokenAddress
              .toString(),
          incentiveController: request.userIncentives.sTokenIncentivesUserData
              .incentiveControllerAddress
              .toString(),
          rewardTokenAddress:
              userReserveIncentive.rewardTokenAddress.toString(),
          rewardTokenDecimals: userReserveIncentive.rewardTokenDecimals.toInt(),
          accruedRewards: accruedRewards,
          unclaimedRewards:
              userReserveIncentive.userUnclaimedRewards.toDecimal(),
          rewardPriceFeed: normalize(
            userReserveIncentive.rewardPriceFeed,
            userReserveIncentive.priceFeedDecimals.toInt(),
          ),
          rewardTokenSymbol: userReserveIncentive.rewardTokenSymbol,
        ),
      );
    }
  }

  return calculatedUserIncentives;
}

Map<String, FormatedUserIncentiveData> calculateAllUserIncentives(
    CalculateAllUserIncentivesRequest request) {
  var allRewards = request.userIncentives.expand((userIncentive) {
    var reserve = request.reserveIncentives.firstWhereOrNull(
        (reserve) => reserve.underlyingAsset == userIncentive.underlyingAsset);
    var userReserve = request.userReserves.firstWhereOrNull((userReserve) =>
        userReserve.underlyingAsset ==
        userIncentive.underlyingAsset.toString());

    var reserveRewards =
        calculateUserReserveIncentives(CalculateUserReserveIncentivesRequest(
      reserveIncentives: reserve!,
      userIncentives: userIncentive,
      userReserve: userReserve,
      currentTimestamp: request.currentTimestamp,
    ));
    return reserveRewards;
  }).toList();

  var incentiveDict = <String, FormatedUserIncentiveData>{};
  for (var reward in allRewards) {
    if (!incentiveDict.containsKey(reward.rewardTokenAddress)) {
      incentiveDict[reward.rewardTokenAddress] = FormatedUserIncentiveData(
          assets: [],
          rewardTokenSymbol: reward.rewardTokenSymbol,
          claimableRewards: reward.unclaimedRewards,
          incentiveControllerAddress: reward.incentiveController,
          rewardTokenDecimals: reward.rewardTokenDecimals,
          rewardPriceFeed: reward.rewardPriceFeed);
    }

    if (reward.accruedRewards > Decimal.zero) {
      incentiveDict[reward.rewardTokenAddress]!.claimableRewards +=
          reward.accruedRewards;
      incentiveDict[reward.rewardTokenAddress]!.assets.add(reward.tokenAddress);
    }
  }

  return incentiveDict;
}

class ReserveIncentive {
  Decimal incentiveAPR;
  String rewardTokenAddress;
  String rewardTokenSymbol;

  ReserveIncentive({
    required this.incentiveAPR,
    required this.rewardTokenAddress,
    required this.rewardTokenSymbol,
  });

  Map<String, dynamic> toJson() {
    return {
      'incentiveAPR': incentiveAPR.toString(),
      'rewardTokenAddress': rewardTokenAddress,
      'rewardTokenSymbol': rewardTokenSymbol,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ReserveIncentives {
  List<ReserveIncentive> aIncentives;
  List<ReserveIncentive> vIncentives;
  List<ReserveIncentive> sIncentives;

  ReserveIncentives({
    required this.aIncentives,
    required this.vIncentives,
    required this.sIncentives,
  });

  Map<String, dynamic> toJson() {
    return {
      'aIncentives':
          aIncentives.map((incentive) => incentive.toJson()).toList(),
      'vIncentives':
          vIncentives.map((incentive) => incentive.toJson()).toList(),
      'sIncentives':
          sIncentives.map((incentive) => incentive.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class CalculateAllReserveIncentivesRequest {
  List<AggregatedReserveIncentiveData> reserveIncentives;
  List<ReserveCalculationData> reserves;
  int marketReferenceCurrencyDecimals;

  CalculateAllReserveIncentivesRequest({
    required this.reserveIncentives,
    required this.reserves,
    required this.marketReferenceCurrencyDecimals,
  });
}

class CalculateReserveIncentivesRequest {
  List<Reserve> reserves;
  AggregatedReserveIncentiveData reserveIncentiveData;
  Decimal totalLiquidity;
  Decimal totalVariableDebt;
  Decimal totalStableDebt;
  int decimals;
  Decimal priceInMarketReferenceCurrency;
  int marketReferenceCurrencyDecimals;

  CalculateReserveIncentivesRequest({
    required this.reserves,
    required this.reserveIncentiveData,
    required this.totalLiquidity,
    required this.totalVariableDebt,
    required this.totalStableDebt,
    required this.decimals,
    required this.priceInMarketReferenceCurrency,
    required this.marketReferenceCurrencyDecimals,
  });
}

Decimal calculateRewardTokenPrice(
  List<Reserve> reserves,
  String address,
  Decimal priceFeed,
  int priceFeedDecimals,
) {
  // For V3 incentives, all rewards will have attached price feed
  if (priceFeed > Decimal.fromInt(0)) {
    return normalize(priceFeed, priceFeedDecimals);
  }

  address = address.toLowerCase();
  // For stkAave incentives, use Aave price feed
  if (address.toLowerCase() == '0x4da27a545c0c5b758a6ba100e3a049001de870f5') {
    address = '0x7fc66500c84a76ad7e9c93437bfc5ac33e2ddae9';
  }

  // // For V2 incentives, reward price feed comes from the reserves
  // Reserve? rewardReserve = reserves.firstWhere(
  //   (reserve) => reserve.underlyingAsset.toLowerCase() == address,
  //   orElse: () => null,
  // );
  // if (rewardReserve != null) {
  //   return rewardReserve.formattedPriceInMarketReferenceCurrency;
  // }

  return Decimal.zero;
}

// Determine is reward emsission is active or distribution has ended
bool rewardEmissionActive(RewardInfo reward) {
  if (reward.emissionEndTimestamp > reward.incentivesLastUpdateTimestamp) {
    return true;
  }

  return false;
}

class CalculateIncentiveAPRRequest {
  Decimal emissionPerSecond;
  Decimal
      rewardTokenPriceInMarketReferenceCurrency; // Can be priced in ETH or USD depending on market
  Decimal totalTokenSupply;
  Decimal
      priceInMarketReferenceCurrency; // Can be priced in ETH or USD depending on market
  int decimals;
  int rewardTokenDecimals;

  CalculateIncentiveAPRRequest({
    required this.emissionPerSecond,
    required this.rewardTokenPriceInMarketReferenceCurrency,
    required this.totalTokenSupply,
    required this.priceInMarketReferenceCurrency,
    required this.decimals,
    required this.rewardTokenDecimals,
  });
}

// Calculate the APR for an incentive emission
Decimal calculateIncentiveAPR(CalculateIncentiveAPRRequest request) {
  Decimal emissionPerSecondNormalized = normalizeBN(
        request.emissionPerSecond,
        WEI_DECIMALS,
      ) *
      request.rewardTokenPriceInMarketReferenceCurrency;

  if (emissionPerSecondNormalized == Decimal.zero) {
    return Decimal.zero;
  }

  final emissionPerYear = emissionPerSecondNormalized * SECONDS_PER_YEAR.toDecimal();

  Decimal totalSupplyNormalized =
      normalize(request.totalTokenSupply, request.decimals) *
          request.priceInMarketReferenceCurrency;

  return (emissionPerYear / totalSupplyNormalized)
      .toDecimal(scaleOnInfinitePrecision: 27);
}

// Calculate supply, variableBorrow, and stableBorrow incentives APR for a reserve asset
CalculateReserveIncentivesResponse calculateReserveIncentives(
    CalculateReserveIncentivesRequest request) {
  List<ReserveIncentiveResponse> aIncentivesData = request
      .reserveIncentiveData.aIncentiveData.rewardsTokenInformation
      .map((reward) {
    final aIncentivesAPR = rewardEmissionActive(reward)
        ? calculateIncentiveAPR(CalculateIncentiveAPRRequest(
            emissionPerSecond: reward.emissionPerSecond.toDecimal(),
            rewardTokenPriceInMarketReferenceCurrency:
                calculateRewardTokenPrice(
              request.reserves,
              reward.rewardTokenAddress.toString(),
              reward.rewardPriceFeed.toDecimal(),
              reward.priceFeedDecimals.toInt(),
            ),
            totalTokenSupply: request.totalLiquidity,
            priceInMarketReferenceCurrency:
                request.priceInMarketReferenceCurrency,
            decimals: request.decimals,
            rewardTokenDecimals: reward.rewardTokenDecimals.toInt()))
        : Decimal.zero;
    return ReserveIncentiveResponse(
      incentiveAPR: aIncentivesAPR,
      rewardTokenAddress: reward.rewardTokenAddress.toString(),
      rewardTokenSymbol: reward.rewardTokenSymbol,
    );
  }).toList();

  final vIncentivesData = request
      .reserveIncentiveData.vIncentiveData.rewardsTokenInformation
      .map((reward) {
    final vIncentivesAPR = rewardEmissionActive(reward)
        ? calculateIncentiveAPR(CalculateIncentiveAPRRequest(
            emissionPerSecond: reward.emissionPerSecond.toDecimal(),
            rewardTokenPriceInMarketReferenceCurrency:
                calculateRewardTokenPrice(
              request.reserves,
              reward.rewardTokenAddress.toString(),
              reward.rewardPriceFeed.toDecimal(),
              reward.priceFeedDecimals.toInt(),
            ),
            totalTokenSupply: request.totalVariableDebt,
            priceInMarketReferenceCurrency:
                request.priceInMarketReferenceCurrency,
            decimals: request.decimals,
            rewardTokenDecimals: reward.rewardTokenDecimals.toInt()))
        : Decimal.zero;
    return ReserveIncentiveResponse(
      incentiveAPR: vIncentivesAPR,
      rewardTokenAddress: reward.rewardTokenAddress.toString(),
      rewardTokenSymbol: reward.rewardTokenSymbol,
    );
  }).toList();

  final sIncentivesData = request
      .reserveIncentiveData.sIncentiveData.rewardsTokenInformation
      .map((reward) {
    final sIncentivesAPR = rewardEmissionActive(reward)
        ? calculateIncentiveAPR(CalculateIncentiveAPRRequest(
            emissionPerSecond: reward.emissionPerSecond.toDecimal(),
            rewardTokenPriceInMarketReferenceCurrency:
                calculateRewardTokenPrice(
              request.reserves,
              reward.rewardTokenAddress.toString(),
              reward.rewardPriceFeed.toDecimal(),
              reward.priceFeedDecimals.toInt(),
            ),
            totalTokenSupply: request.totalStableDebt,
            priceInMarketReferenceCurrency:
                request.priceInMarketReferenceCurrency,
            decimals: request.decimals,
            rewardTokenDecimals: reward.rewardTokenDecimals.toInt()))
        : Decimal.zero;
    return ReserveIncentiveResponse(
      incentiveAPR: sIncentivesAPR,
      rewardTokenAddress: reward.rewardTokenAddress.toString(),
      rewardTokenSymbol: reward.rewardTokenSymbol,
    );
  }).toList();

  return CalculateReserveIncentivesResponse(
    underlyingAsset: request.reserveIncentiveData.underlyingAsset.toString(),
    aIncentivesData: aIncentivesData,
    vIncentivesData: vIncentivesData,
    sIncentivesData: sIncentivesData,
  );
}

Map<String, ReserveIncentives> calculateAllReserveIncentives(
    CalculateAllReserveIncentivesRequest request) {
  Map<String, ReserveIncentives> reserveDict = {};
  final reserves = request.reserves
      .map((reserve) => Reserve(
            underlyingAsset: reserve.underlyingAsset,
            formattedPriceInMarketReferenceCurrency:
                reserve.formattedPriceInMarketReferenceCurrency,
          ))
      .toList();
  // calculate incentive per reserve token
  for (var reserveIncentive in request.reserveIncentives) {
    // Find the corresponding reserve data for each reserveIncentive
    final reserve = request.reserves.firstWhereOrNull((reserve) =>
        reserve.underlyingAsset.toLowerCase() ==
        reserveIncentive.underlyingAsset.toString().toLowerCase());

    if (reserve != null) {
      final calculatedReserveIncentives = calculateReserveIncentives(
          CalculateReserveIncentivesRequest(
              reserves: reserves,
              reserveIncentiveData: reserveIncentive,
              totalLiquidity: reserve.totalLiquidity,
              totalVariableDebt: reserve.totalVariableDebt,
              totalStableDebt: reserve.totalStableDebt,
              decimals: reserve.decimals,
              priceInMarketReferenceCurrency:
                  reserve.formattedPriceInMarketReferenceCurrency,
              marketReferenceCurrencyDecimals:
                  request.marketReferenceCurrencyDecimals));

      reserveDict[calculatedReserveIncentives.underlyingAsset] =
          ReserveIncentives(
        aIncentives: calculatedReserveIncentives.aIncentivesData
            .map((incentive) => ReserveIncentive(
                  incentiveAPR: incentive.incentiveAPR,
                  rewardTokenAddress: incentive.rewardTokenAddress,
                  rewardTokenSymbol: incentive.rewardTokenSymbol,
                ))
            .toList(),
        vIncentives: calculatedReserveIncentives.vIncentivesData
            .map((incentive) => ReserveIncentive(
                  incentiveAPR: incentive.incentiveAPR,
                  rewardTokenAddress: incentive.rewardTokenAddress,
                  rewardTokenSymbol: incentive.rewardTokenSymbol,
                ))
            .toList(),
        sIncentives: calculatedReserveIncentives.sIncentivesData
            .map((incentive) => ReserveIncentive(
                  incentiveAPR: incentive.incentiveAPR,
                  rewardTokenAddress: incentive.rewardTokenAddress,
                  rewardTokenSymbol: incentive.rewardTokenSymbol,
                ))
            .toList(),
      );
    }
  }

  return reserveDict;
}
