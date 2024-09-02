// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"contract IPool","name":"pool","type":"address"},{"internalType":"contract IGhoToken","name":"ghoToken","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"GHO","outputs":[{"internalType":"contract IGhoToken","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"POOL","outputs":[{"internalType":"contract IPool","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getGhoReserveData","outputs":[{"components":[{"internalType":"uint256","name":"ghoBaseVariableBorrowRate","type":"uint256"},{"internalType":"uint256","name":"ghoDiscountedPerToken","type":"uint256"},{"internalType":"uint256","name":"ghoDiscountRate","type":"uint256"},{"internalType":"uint256","name":"ghoMinDebtTokenBalanceForDiscount","type":"uint256"},{"internalType":"uint256","name":"ghoMinDiscountTokenBalanceForDiscount","type":"uint256"},{"internalType":"uint40","name":"ghoReserveLastUpdateTimestamp","type":"uint40"},{"internalType":"uint128","name":"ghoCurrentBorrowIndex","type":"uint128"},{"internalType":"uint256","name":"aaveFacilitatorBucketLevel","type":"uint256"},{"internalType":"uint256","name":"aaveFacilitatorBucketMaxCapacity","type":"uint256"}],"internalType":"struct IUiGhoDataProvider.GhoReserveData","name":"","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"user","type":"address"}],"name":"getGhoUserData","outputs":[{"components":[{"internalType":"uint256","name":"userGhoDiscountPercent","type":"uint256"},{"internalType":"uint256","name":"userDiscountTokenBalance","type":"uint256"},{"internalType":"uint256","name":"userPreviousGhoBorrowIndex","type":"uint256"},{"internalType":"uint256","name":"userGhoScaledBorrowBalance","type":"uint256"}],"internalType":"struct IUiGhoDataProvider.GhoUserData","name":"","type":"tuple"}],"stateMutability":"view","type":"function"}]',
  'Gho_ui_data_provider',
);

class Gho_ui_data_provider extends _i1.GeneratedContract {
  Gho_ui_data_provider({
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
  Future<_i1.EthereumAddress> GHO({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'b8d008f3'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> POOL({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '7535d246'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getGhoReserveData({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'f5a5b364'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getGhoUserData(
    ({_i1.EthereumAddress user}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '82d761a9'));
    final params = [args.user];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }
}
