import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletState {
  final String currentAccount;
  final int currentChain;
  WalletState(this.currentAccount, this.currentChain);
}

class Wallet extends StateNotifier<WalletState> {
  Wallet()
      : super(WalletState('0x077A79ab65cAAbAa684f34Cc22aCa911742690E0', 1));
  bool get isEnable => true;

  connect() async {}
  disConnect() async {}

  changeChain(int chainId) async {
    if (isEnable) {
      state = WalletState(state.currentAccount, chainId);
    }
  }

  clear() {
    state = WalletState('', 0);
  }
}

final walletStateProvider = StateNotifierProvider<Wallet, WalletState>((ref) {
  final wallet = Wallet();
  return wallet;
});

final walletAccountProvider = StateProvider<String>((ref) {
  final state = ref.watch(walletStateProvider);
  return state.currentAccount;
});

final walletConnectProvider = StateProvider<bool>((ref) {
  return false;
});

final walletChainProvider = StateProvider<int>((ref) {
  final state = ref.watch(walletStateProvider);
  return state.currentChain;
});
