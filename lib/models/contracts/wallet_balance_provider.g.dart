// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"user","type":"address"},{"internalType":"address","name":"token","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address[]","name":"users","type":"address[]"},{"internalType":"address[]","name":"tokens","type":"address[]"}],"name":"batchBalanceOf","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"provider","type":"address"},{"internalType":"address","name":"user","type":"address"}],"name":"getUserWalletBalances","outputs":[{"internalType":"address[]","name":"","type":"address[]"},{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"stateMutability":"payable","type":"receive"}]',
  'Wallet_balance_provider',
);

class Wallet_balance_provider extends _i1.GeneratedContract {
  Wallet_balance_provider({
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
  Future<BigInt> balanceOf(
    ({_i1.EthereumAddress user, _i1.EthereumAddress token}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'f7888aec'));
    final params = [
      args.user,
      args.token,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> batchBalanceOf(
    ({
      List<_i1.EthereumAddress> users,
      List<_i1.EthereumAddress> tokens
    }) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'b59b28ef'));
    final params = [
      args.users,
      args.tokens,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetUserWalletBalances> getUserWalletBalances(
    ({_i1.EthereumAddress provider, _i1.EthereumAddress user}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '02405343'));
    final params = [
      args.provider,
      args.user,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetUserWalletBalances(response);
  }
}

class GetUserWalletBalances {
  GetUserWalletBalances(List<dynamic> response)
      : var1 = (response[0] as List<dynamic>).cast<_i1.EthereumAddress>(),
        var2 = (response[1] as List<dynamic>).cast<BigInt>();

  final List<_i1.EthereumAddress> var1;

  final List<BigInt> var2;
}
