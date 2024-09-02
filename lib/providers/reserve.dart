import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import 'package:tlend_app/models/reserve.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/abi/ui_pool_data_provider.dart';

final timerProvider = StreamProvider<void>((ref) {
  return Stream.periodic(const Duration(minutes: 1));
});

final reservesDataProvider = FutureProvider<ReservesData>((ref) async {
  ref.watch(timerProvider);
  final chainId = ref.watch(networkProvider);
  final rpcInfo = ref.watch(rpcProvider);
  final web3Client = rpcInfo.web3Client;

  final contractAddress = EthereumAddress.fromHex(
      allNetworks[chainId]!.contracts['ui_pool_data_provider']!);

  final contract = DeployedContract(
      ContractAbi.fromJson(ui_pool_data_provider_abi, 'UiPoolDataProvider'),
      contractAddress);

  final args = EthereumAddress.fromHex(
      allNetworks[chainId]!.contracts['pool_address_provider']!);
  final outputs = await web3Client.call(
      contract: contract,
      function: contract.function('getReservesData'),
      params: [args]);

  return ReservesData(outputs);
});

final userReservesDataProvider = FutureProvider<UserReservesData>((ref) async {
  ref.watch(timerProvider);
  final chainId = ref.watch(networkProvider);
  final rpcInfo = ref.watch(rpcProvider);
  final userAddress = ref.watch(walletAccountProvider);

  final web3Client = rpcInfo.web3Client;
  final contractAddress = EthereumAddress.fromHex(
      allNetworks[chainId]!.contracts['ui_pool_data_provider']!);

  final contract = DeployedContract(
      ContractAbi.fromJson(ui_pool_data_provider_abi, 'UiPoolDataProvider'),
      contractAddress);

  final outputs = await web3Client.call(
      contract: contract,
      function: contract.function('getUserReservesData'),
      params: [
        EthereumAddress.fromHex(
            allNetworks[chainId]!.contracts['pool_address_provider']!),
        EthereumAddress.fromHex(userAddress)
      ]);

  return UserReservesData(outputs);
});
