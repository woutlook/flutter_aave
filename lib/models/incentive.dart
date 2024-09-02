import 'package:web3dart/web3dart.dart';

class AggregatedReserveIncentiveData {
  EthereumAddress underlyingAsset;
  IncentiveData aIncentiveData;
  IncentiveData vIncentiveData;
  IncentiveData sIncentiveData;

  AggregatedReserveIncentiveData(dynamic data)
      : underlyingAsset = data[0],
        aIncentiveData = IncentiveData(data[1]),
        vIncentiveData = IncentiveData(data[2]),
        sIncentiveData = IncentiveData(data[3]);

  Map<String, dynamic> toJson() {
    return {
      'underlyingAsset': underlyingAsset.toString(),
      'aIncentiveData': aIncentiveData.toJson(),
      'vIncentiveData': vIncentiveData.toJson(),
      'sIncentiveData': sIncentiveData.toJson(),
    };
  }
}

class IncentiveData {
  EthereumAddress tokenAddress;
  EthereumAddress incentiveControllerAddress;
  List<RewardInfo> rewardsTokenInformation;

  IncentiveData(dynamic data)
      : tokenAddress = data[0],
        incentiveControllerAddress = data[1],
        rewardsTokenInformation =
            (data[2] as List<dynamic>).map((item) => RewardInfo(item)).toList();

  Map<String, dynamic> toJson() {
    return {
      'tokenAddress': tokenAddress.toString(),
      'incentiveControllerAddress': incentiveControllerAddress.toString(),
      'rewardsTokenInformation':
          rewardsTokenInformation.take(1).map((item) => item.toJson()).toList(),
    };
  }
}

class RewardInfo {
  String rewardTokenSymbol;
  EthereumAddress rewardTokenAddress;
  EthereumAddress rewardOracleAddress;
  BigInt emissionPerSecond;
  BigInt incentivesLastUpdateTimestamp;
  BigInt tokenIncentivesIndex;
  BigInt emissionEndTimestamp;
  BigInt rewardPriceFeed;
  BigInt rewardTokenDecimals;
  BigInt precision;
  BigInt priceFeedDecimals;

  // RewardInfo()
  //     : rewardTokenSymbol = '',
  //       rewardTokenAddress = EthereumAddress.fromHex(''),
  //       rewardOracleAddress = EthereumAddress.fromHex(''),
  //       emissionPerSecond = BigInt.zero,
  //       incentivesLastUpdateTimestamp = BigInt.zero,
  //       tokenIncentivesIndex = BigInt.zero,
  //       emissionEndTimestamp = BigInt.zero,
  //       rewardPriceFeed = BigInt.zero,
  //       rewardTokenDecimals = BigInt.zero,
  //       precision = BigInt.zero,
  //       priceFeedDecimals = BigInt.zero;

  RewardInfo(dynamic data)
      : rewardTokenSymbol = data[0],
        rewardTokenAddress = data[1],
        rewardOracleAddress = data[2],
        emissionPerSecond = data[3],
        incentivesLastUpdateTimestamp = data[4],
        tokenIncentivesIndex = data[5],
        emissionEndTimestamp = data[6],
        rewardPriceFeed = data[7],
        rewardTokenDecimals = data[8],
        precision = data[9],
        priceFeedDecimals = data[10];

  Map<String, dynamic> toJson() {
    return {
      'rewardTokenSymbol': rewardTokenSymbol,
      'rewardTokenAddress': rewardTokenAddress.toString(),
      'rewardOracleAddress': rewardOracleAddress.toString(),
      'emissionPerSecond': emissionPerSecond.toString(),
      'incentivesLastUpdateTimestamp': incentivesLastUpdateTimestamp.toString(),
      'tokenIncentivesIndex': tokenIncentivesIndex.toString(),
      'emissionEndTimestamp': emissionEndTimestamp.toString(),
      'rewardPriceFeed': rewardPriceFeed.toString(),
      'rewardTokenDecimals': rewardTokenDecimals.toString(),
      'precision': precision.toString(),
      'priceFeedDecimals': priceFeedDecimals.toString(),
    };
  }
}

class UserReserveIncentiveData {
  EthereumAddress underlyingAsset;
  UserIncentiveData aTokenIncentivesUserData;
  UserIncentiveData vTokenIncentivesUserData;
  UserIncentiveData sTokenIncentivesUserData;

  UserReserveIncentiveData(dynamic data)
      : underlyingAsset = data[0],
        aTokenIncentivesUserData = UserIncentiveData(data[1]),
        vTokenIncentivesUserData = UserIncentiveData(data[2]),
        sTokenIncentivesUserData = UserIncentiveData(data[3]);

  Map<String, dynamic> toJson() {
    return {
      'underlyingAsset': underlyingAsset.toString(),
      'aTokenIncentivesUserData': aTokenIncentivesUserData.toJson(),
      'vTokenIncentivesUserData': vTokenIncentivesUserData.toJson(),
      'sTokenIncentivesUserData': sTokenIncentivesUserData.toJson(),
    };
  }
}

class UserIncentiveData {
  EthereumAddress tokenAddress;
  EthereumAddress incentiveControllerAddress;
  List<UserRewardInfo> userRewardsInformation;

  UserIncentiveData(dynamic data)
      : tokenAddress = data[0],
        incentiveControllerAddress = data[1],
        userRewardsInformation = (data[2] as List<dynamic>)
            .map((item) => UserRewardInfo(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'tokenAddress': tokenAddress.toString(),
      'incentiveControllerAddress': incentiveControllerAddress.toString(),
      'userRewardsInformation':
          userRewardsInformation.take(1).map((item) => item.toJson()).toList(),
    };
  }
}

class UserRewardInfo {
  String rewardTokenSymbol;
  EthereumAddress rewardOracleAddress;
  EthereumAddress rewardTokenAddress;
  BigInt userUnclaimedRewards;
  BigInt tokenIncentivesUserIndex;
  BigInt rewardPriceFeed;
  BigInt priceFeedDecimals;
  BigInt rewardTokenDecimals;

  UserRewardInfo(dynamic data)
      : rewardTokenSymbol = data[0],
        rewardOracleAddress = data[1],
        rewardTokenAddress = data[2],
        userUnclaimedRewards = data[3],
        tokenIncentivesUserIndex = data[4],
        rewardPriceFeed = data[5],
        priceFeedDecimals = data[6],
        rewardTokenDecimals = data[7];

  Map<String, dynamic> toJson() {
    return {
      'rewardTokenSymbol': rewardTokenSymbol,
      'rewardOracleAddress': rewardOracleAddress.toString(),
      'rewardTokenAddress': rewardTokenAddress.toString(),
      'userUnclaimedRewards': userUnclaimedRewards.toString(),
      'tokenIncentivesUserIndex': tokenIncentivesUserIndex.toString(),
      'rewardPriceFeed': rewardPriceFeed.toString(),
      'priceFeedDecimals': priceFeedDecimals.toString(),
      'rewardTokenDecimals': rewardTokenDecimals.toString(),
    };
  }
}
