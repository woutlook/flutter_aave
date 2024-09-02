// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"string","name":"marketId","type":"string"},{"internalType":"address","name":"owner","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"ACLAdminUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"ACLManagerUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"id","type":"bytes32"},{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"AddressSet","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"id","type":"bytes32"},{"indexed":true,"internalType":"address","name":"proxyAddress","type":"address"},{"indexed":false,"internalType":"address","name":"oldImplementationAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newImplementationAddress","type":"address"}],"name":"AddressSetAsProxy","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"string","name":"oldMarketId","type":"string"},{"indexed":true,"internalType":"string","name":"newMarketId","type":"string"}],"name":"MarketIdSet","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"PoolConfiguratorUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"PoolDataProviderUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"PoolUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"PriceOracleSentinelUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"oldAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newAddress","type":"address"}],"name":"PriceOracleUpdated","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"id","type":"bytes32"},{"indexed":true,"internalType":"address","name":"proxyAddress","type":"address"},{"indexed":true,"internalType":"address","name":"implementationAddress","type":"address"}],"name":"ProxyCreated","type":"event"},{"inputs":[],"name":"getACLAdmin","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getACLManager","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"id","type":"bytes32"}],"name":"getAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getMarketId","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPool","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPoolConfigurator","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPoolDataProvider","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPriceOracle","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getPriceOracleSentinel","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newAclAdmin","type":"address"}],"name":"setACLAdmin","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newAclManager","type":"address"}],"name":"setACLManager","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"id","type":"bytes32"},{"internalType":"address","name":"newAddress","type":"address"}],"name":"setAddress","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"id","type":"bytes32"},{"internalType":"address","name":"newImplementationAddress","type":"address"}],"name":"setAddressAsProxy","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"newMarketId","type":"string"}],"name":"setMarketId","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newPoolConfiguratorImpl","type":"address"}],"name":"setPoolConfiguratorImpl","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newDataProvider","type":"address"}],"name":"setPoolDataProvider","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newPoolImpl","type":"address"}],"name":"setPoolImpl","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newPriceOracle","type":"address"}],"name":"setPriceOracle","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newPriceOracleSentinel","type":"address"}],"name":"setPriceOracleSentinel","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'Pool_address_provider',
);

class Pool_address_provider extends _i1.GeneratedContract {
  Pool_address_provider({
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
  Future<_i1.EthereumAddress> getACLAdmin({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '0e67178c'));
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
  Future<_i1.EthereumAddress> getACLManager({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '707cd716'));
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
  Future<_i1.EthereumAddress> getAddress(
    ({_i2.Uint8List id}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '21f8a721'));
    final params = [args.id];
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
  Future<String> getMarketId({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '568ef470'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> getPool({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '026b1d5f'));
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
  Future<_i1.EthereumAddress> getPoolConfigurator(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '631adfca'));
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
  Future<_i1.EthereumAddress> getPoolDataProvider(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'e860accb'));
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
  Future<_i1.EthereumAddress> getPriceOracle({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'fca513a8'));
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
  Future<_i1.EthereumAddress> getPriceOracleSentinel(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '5eb88d3d'));
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
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> renounceOwnership({
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '715018a6'));
    final params = [];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setACLAdmin(
    ({_i1.EthereumAddress newAclAdmin}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '76d84ffc'));
    final params = [args.newAclAdmin];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setACLManager(
    ({_i1.EthereumAddress newAclManager}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, 'ed301ca9'));
    final params = [args.newAclManager];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setAddress(
    ({_i2.Uint8List id, _i1.EthereumAddress newAddress}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, 'ca446dd9'));
    final params = [
      args.id,
      args.newAddress,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setAddressAsProxy(
    ({_i2.Uint8List id, _i1.EthereumAddress newImplementationAddress}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '5dcc528c'));
    final params = [
      args.id,
      args.newImplementationAddress,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setMarketId(
    ({String newMarketId}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, 'f67b1847'));
    final params = [args.newMarketId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPoolConfiguratorImpl(
    ({_i1.EthereumAddress newPoolConfiguratorImpl}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'e4ca28b7'));
    final params = [args.newPoolConfiguratorImpl];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPoolDataProvider(
    ({_i1.EthereumAddress newDataProvider}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'e44e9ed1'));
    final params = [args.newDataProvider];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPoolImpl(
    ({_i1.EthereumAddress newPoolImpl}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, 'a1564406'));
    final params = [args.newPoolImpl];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPriceOracle(
    ({_i1.EthereumAddress newPriceOracle}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '530e784f'));
    final params = [args.newPriceOracle];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setPriceOracleSentinel(
    ({_i1.EthereumAddress newPriceOracleSentinel}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '74944cec'));
    final params = [args.newPriceOracleSentinel];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> transferOwnership(
    ({_i1.EthereumAddress newOwner}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, 'f2fde38b'));
    final params = [args.newOwner];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// Returns a live stream of all ACLAdminUpdated events emitted by this contract.
  Stream<ACLAdminUpdated> aCLAdminUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ACLAdminUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ACLAdminUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ACLManagerUpdated events emitted by this contract.
  Stream<ACLManagerUpdated> aCLManagerUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ACLManagerUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ACLManagerUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all AddressSet events emitted by this contract.
  Stream<AddressSet> addressSetEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('AddressSet');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return AddressSet(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all AddressSetAsProxy events emitted by this contract.
  Stream<AddressSetAsProxy> addressSetAsProxyEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('AddressSetAsProxy');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return AddressSetAsProxy(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all MarketIdSet events emitted by this contract.
  Stream<MarketIdSet> marketIdSetEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('MarketIdSet');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return MarketIdSet(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
  Stream<OwnershipTransferred> ownershipTransferredEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('OwnershipTransferred');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return OwnershipTransferred(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all PoolConfiguratorUpdated events emitted by this contract.
  Stream<PoolConfiguratorUpdated> poolConfiguratorUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('PoolConfiguratorUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return PoolConfiguratorUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all PoolDataProviderUpdated events emitted by this contract.
  Stream<PoolDataProviderUpdated> poolDataProviderUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('PoolDataProviderUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return PoolDataProviderUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all PoolUpdated events emitted by this contract.
  Stream<PoolUpdated> poolUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('PoolUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return PoolUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all PriceOracleSentinelUpdated events emitted by this contract.
  Stream<PriceOracleSentinelUpdated> priceOracleSentinelUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('PriceOracleSentinelUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return PriceOracleSentinelUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all PriceOracleUpdated events emitted by this contract.
  Stream<PriceOracleUpdated> priceOracleUpdatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('PriceOracleUpdated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return PriceOracleUpdated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all ProxyCreated events emitted by this contract.
  Stream<ProxyCreated> proxyCreatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ProxyCreated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ProxyCreated(
        decoded,
        result,
      );
    });
  }
}

class ACLAdminUpdated {
  ACLAdminUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class ACLManagerUpdated {
  ACLManagerUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class AddressSet {
  AddressSet(
    List<dynamic> response,
    this.event,
  )   : id = (response[0] as _i2.Uint8List),
        oldAddress = (response[1] as _i1.EthereumAddress),
        newAddress = (response[2] as _i1.EthereumAddress);

  final _i2.Uint8List id;

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class AddressSetAsProxy {
  AddressSetAsProxy(
    List<dynamic> response,
    this.event,
  )   : id = (response[0] as _i2.Uint8List),
        proxyAddress = (response[1] as _i1.EthereumAddress),
        oldImplementationAddress = (response[2] as _i1.EthereumAddress),
        newImplementationAddress = (response[3] as _i1.EthereumAddress);

  final _i2.Uint8List id;

  final _i1.EthereumAddress proxyAddress;

  final _i1.EthereumAddress oldImplementationAddress;

  final _i1.EthereumAddress newImplementationAddress;

  final _i1.FilterEvent event;
}

class MarketIdSet {
  MarketIdSet(
    List<dynamic> response,
    this.event,
  )   : oldMarketId = (response[0] as String),
        newMarketId = (response[1] as String);

  final String oldMarketId;

  final String newMarketId;

  final _i1.FilterEvent event;
}

class OwnershipTransferred {
  OwnershipTransferred(
    List<dynamic> response,
    this.event,
  )   : previousOwner = (response[0] as _i1.EthereumAddress),
        newOwner = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress previousOwner;

  final _i1.EthereumAddress newOwner;

  final _i1.FilterEvent event;
}

class PoolConfiguratorUpdated {
  PoolConfiguratorUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class PoolDataProviderUpdated {
  PoolDataProviderUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class PoolUpdated {
  PoolUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class PriceOracleSentinelUpdated {
  PriceOracleSentinelUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class PriceOracleUpdated {
  PriceOracleUpdated(
    List<dynamic> response,
    this.event,
  )   : oldAddress = (response[0] as _i1.EthereumAddress),
        newAddress = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress oldAddress;

  final _i1.EthereumAddress newAddress;

  final _i1.FilterEvent event;
}

class ProxyCreated {
  ProxyCreated(
    List<dynamic> response,
    this.event,
  )   : id = (response[0] as _i2.Uint8List),
        proxyAddress = (response[1] as _i1.EthereumAddress),
        implementationAddress = (response[2] as _i1.EthereumAddress);

  final _i2.Uint8List id;

  final _i1.EthereumAddress proxyAddress;

  final _i1.EthereumAddress implementationAddress;

  final _i1.FilterEvent event;
}
