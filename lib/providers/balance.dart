import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/abi/wallet_balance_provider.dart';

final userBalanceProvider = FutureProvider<Map<String, BigInt>>((ref) async {
  final userAddress = ref.watch(walletAccountProvider);
  final chainId = ref.watch(networkProvider);
  final rpcInfo = ref.watch(rpcProvider);

  final web3Client = rpcInfo.web3Client;
  final userBalances = <String, BigInt>{};
  final walletBalanceProviderAddress =
      allNetworks[chainId]!.contracts['wallet_balance_provider'];
  final wbContract = DeployedContract(
      ContractAbi.fromJson(
          wallet_balance_provider_abi, 'WalletBalanceProvider'),
      EthereumAddress.fromHex(walletBalanceProviderAddress!));
  final outputs = await web3Client.call(
      contract: wbContract,
      function: wbContract.function('getUserWalletBalances'),
      params: [
        EthereumAddress.fromHex(
            allNetworks[chainId]!.contracts['pool_address_provider']!),
        EthereumAddress.fromHex(userAddress),
      ]);
  final List<EthereumAddress> addresses =
      (outputs[0] as List).map((item) => item as EthereumAddress).toList();
  final List<BigInt> balances =
      (outputs[1] as List).map((item) => item as BigInt).toList();
  for (var i = 0; i < addresses.length; i++) {
    userBalances[addresses[i].hex] = balances[i];
  }
  return userBalances;
});
