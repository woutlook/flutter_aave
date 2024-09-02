// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"contract IPoolAddressesProvider","name":"provider","type":"address"},{"internalType":"address","name":"user","type":"address"}],"name":"getFullReservesIncentiveData","outputs":[{"components":[{"internalType":"address","name":"underlyingAsset","type":"address"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"aIncentiveData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"vIncentiveData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"sIncentiveData","type":"tuple"}],"internalType":"struct IUiIncentiveDataProviderV3.AggregatedReserveIncentiveData[]","name":"","type":"tuple[]"},{"components":[{"internalType":"address","name":"underlyingAsset","type":"address"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"aTokenIncentivesUserData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"vTokenIncentivesUserData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"sTokenIncentivesUserData","type":"tuple"}],"internalType":"struct IUiIncentiveDataProviderV3.UserReserveIncentiveData[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"contract IPoolAddressesProvider","name":"provider","type":"address"}],"name":"getReservesIncentivesData","outputs":[{"components":[{"internalType":"address","name":"underlyingAsset","type":"address"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"aIncentiveData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"vIncentiveData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"uint256","name":"emissionPerSecond","type":"uint256"},{"internalType":"uint256","name":"incentivesLastUpdateTimestamp","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesIndex","type":"uint256"},{"internalType":"uint256","name":"emissionEndTimestamp","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"},{"internalType":"uint8","name":"precision","type":"uint8"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.RewardInfo[]","name":"rewardsTokenInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.IncentiveData","name":"sIncentiveData","type":"tuple"}],"internalType":"struct IUiIncentiveDataProviderV3.AggregatedReserveIncentiveData[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"contract IPoolAddressesProvider","name":"provider","type":"address"},{"internalType":"address","name":"user","type":"address"}],"name":"getUserReservesIncentivesData","outputs":[{"components":[{"internalType":"address","name":"underlyingAsset","type":"address"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"aTokenIncentivesUserData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"vTokenIncentivesUserData","type":"tuple"},{"components":[{"internalType":"address","name":"tokenAddress","type":"address"},{"internalType":"address","name":"incentiveControllerAddress","type":"address"},{"components":[{"internalType":"string","name":"rewardTokenSymbol","type":"string"},{"internalType":"address","name":"rewardOracleAddress","type":"address"},{"internalType":"address","name":"rewardTokenAddress","type":"address"},{"internalType":"uint256","name":"userUnclaimedRewards","type":"uint256"},{"internalType":"uint256","name":"tokenIncentivesUserIndex","type":"uint256"},{"internalType":"int256","name":"rewardPriceFeed","type":"int256"},{"internalType":"uint8","name":"priceFeedDecimals","type":"uint8"},{"internalType":"uint8","name":"rewardTokenDecimals","type":"uint8"}],"internalType":"struct IUiIncentiveDataProviderV3.UserRewardInfo[]","name":"userRewardsInformation","type":"tuple[]"}],"internalType":"struct IUiIncentiveDataProviderV3.UserIncentiveData","name":"sTokenIncentivesUserData","type":"tuple"}],"internalType":"struct IUiIncentiveDataProviderV3.UserReserveIncentiveData[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"}]',
  'Ui_incentive_data_provider',
);

class Ui_incentive_data_provider extends _i1.GeneratedContract {
  Ui_incentive_data_provider({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetFullReservesIncentiveData> getFullReservesIncentiveData(
    ({_i1.EthereumAddress provider, _i1.EthereumAddress user}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '47637536'));
    final params = [
      args.provider,
      args.user,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetFullReservesIncentiveData(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getReservesIncentivesData(
    ({_i1.EthereumAddress provider}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '976fafc5'));
    final params = [args.provider];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getUserReservesIncentivesData(
    ({_i1.EthereumAddress provider, _i1.EthereumAddress user}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '799bdcf5'));
    final params = [
      args.provider,
      args.user,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }
}

class GetFullReservesIncentiveData {
  GetFullReservesIncentiveData(List<dynamic> response)
      : var1 = (response[0] as List<dynamic>).cast<dynamic>(),
        var2 = (response[1] as List<dynamic>).cast<dynamic>();

  final List<dynamic> var1;

  final List<dynamic> var2;
}
