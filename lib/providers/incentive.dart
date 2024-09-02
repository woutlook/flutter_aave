import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import 'package:tlend_app/models/incentive.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/abi/ui_incentive_data_provider.dart';

final incentivesProvider =
    FutureProvider<List<AggregatedReserveIncentiveData>>((ref) async {
  final chainId = ref.watch(networkProvider);
  final rpcInfo = ref.watch(rpcProvider);
  final web3Client = rpcInfo.web3Client;

  final contractAddress = EthereumAddress.fromHex(
      allNetworks[chainId]!.contracts['ui_incentive_data_provider']!);

  final contract = DeployedContract(
      ContractAbi.fromJson(
          ui_incentive_data_provider_abi, 'UiIncentiveDataProvider'),
      contractAddress);

  final outputs = await web3Client.call(
      contract: contract,
      function: contract.function('getReservesIncentivesData'),
      params: [
        EthereumAddress.fromHex(
            allNetworks[chainId]!.contracts['pool_address_provider']!)
      ]);

  return (outputs[0] as List<dynamic>)
      .map((item) => AggregatedReserveIncentiveData(item))
      .toList();
});

final userIncentivesProvider =
    FutureProvider<List<UserReserveIncentiveData>>((ref) async {
  final chainId = ref.watch(networkProvider);
  final rpcInfo = ref.watch(rpcProvider);
  final userAddress = ref.watch(walletAccountProvider);
  final web3Client = rpcInfo.web3Client;

  final contractAddress = EthereumAddress.fromHex(
      allNetworks[chainId]!.contracts['ui_incentive_data_provider']!);

  final contract = DeployedContract(
      ContractAbi.fromJson(
          ui_incentive_data_provider_abi, 'UiIncentiveDataProvider'),
      contractAddress);

  final outputs = await web3Client.call(
      contract: contract,
      function: contract.function('getUserReservesIncentivesData'),
      params: [
        EthereumAddress.fromHex(
            allNetworks[chainId]!.contracts['pool_address_provider']!),
        EthereumAddress.fromHex(userAddress)
      ]);

  return (outputs[0] as List<dynamic>)
      .map((item) => UserReserveIncentiveData(item))
      .toList();
});
