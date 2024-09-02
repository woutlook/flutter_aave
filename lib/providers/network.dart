import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tlend_app/config/const.dart';
import 'package:web3dart/web3dart.dart';

import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/providers/platform/platform.dart';

final networkProvider = StateProvider<int>((ref) => ChainId.ethereum.id);

class RpcInfo {
  final String apiUrl;
  late Web3Client web3Client;
  RpcInfo({required this.apiUrl}) {
    var client = httpClient();
    web3Client = Web3Client(apiUrl, client);
  }
}

class RpcNotifier extends StateNotifier<RpcInfo> {
  RpcNotifier(super.state);
}

final rpcProvider = StateNotifierProvider<RpcNotifier, RpcInfo>((ref) {
  final chainId = ref.watch(networkProvider);
  final apiUrl = allNetworks[chainId]!.apiUrl;
  return RpcNotifier(RpcInfo(apiUrl: apiUrl[0]));
});

void changeNetwork(int chainId, ProviderRef ref) {
  if (!suportedNetworks.contains(chainId)) {
    throw UnsupportedError('Unsupported network');
  }
  ref.read(networkProvider.notifier).state = chainId;
}

final testNetworkProvider = StateProvider<bool>((ref) {
  return false;
});

// Dart
Future<void> changeTestNetwork(isTestnet, ref) async {
  await Future.delayed(const Duration(milliseconds: 100));
  ref.read(testNetworkProvider.notifier).state = isTestnet;
}
