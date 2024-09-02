import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web3/flutter_web3.dart';

import 'package:tlend_app/models/wallet.dart';
import 'package:tlend_app/abi/pool.dart';
import 'package:tlend_app/config/contracts.dart';

class WalletState {
  final String currentAccount;
  final int currentChain;
  WalletState(this.currentAccount, this.currentChain);
}

class Wallet extends StateNotifier<WalletState> {
  Wallet() : super(WalletState('', 1));
  bool get isEnable => ethereum != null;
  // bool get isConnect => isEnable && state.currentAccount.isNotEmpty;

  connect() async {
    String currentAccount = '';
    int currentChain = 1;
    if (isEnable) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAccount = accs[0];
      }
      currentChain = await ethereum!.getChainId();
      state = WalletState(currentAccount, currentChain);
    }
  }

  changeChain(int chainId) async {
    if (isEnable) {
      await ethereum!.walletSwitchChain(chainId);
    }
  }

  clear() {
    state = WalletState('', 1);
  }

  init() {
    if (isEnable) {
      ethereum!.onAccountsChanged((accounts) {
        state = WalletState(
            accounts.isNotEmpty ? accounts[0] : '', state.currentChain);
      });
      ethereum!.onChainChanged((chainId) {
        state = WalletState(state.currentAccount, chainId);
      });
    }
  }
}

final walletStateProvider = StateNotifierProvider<Wallet, WalletState>((ref) {
  final wallet = Wallet();
  wallet.init();
  return wallet;
});

final walletAccountProvider = StateProvider<String>((ref) {
  final state = ref.watch(walletStateProvider);
  return state.currentAccount;
});

final walletConnectProvider = StateProvider<bool>((ref) {
  if (ethereum != null) {
    return ethereum!.isConnected();
  }
  return false;
});

final walletChainProvider = StateProvider<int>((ref) {
  final state = ref.watch(walletStateProvider);
  return state.currentChain;
});

Future<TransactionResponse> supply(SupplyParams params) async {
  if (ethereum != null) {
    final signer = provider!.getSigner();
    final to = await signer.getAddress();
    final pool =
        Contract(Contracts.contracts(params.chainId)['pool'], pool_abi, signer);
    return await pool.send('supply', [params.address, params.amount, to, 0]);
  } else {
    throw Exception('No wallet connected');
  }
}

Future<TransactionResponse> withdraw(WithdrawParams params) async {
  if (ethereum != null) {
    final signer = provider!.getSigner();
    final to = await signer.getAddress();
    final pool =
        Contract(Contracts.contracts(params.chainId)['pool'], pool_abi, signer);
    return await pool.send('withdraw', [params.address, params.amount, to]);
  } else {
    throw Exception('No wallet connected');
  }
}

Future<TransactionResponse> borrow(BorrowParams params) async {
  if (ethereum != null) {
    final signer = provider!.getSigner();
    final to = await signer.getAddress();
    final pool =
        Contract(Contracts.contracts(params.chainId)['pool'], pool_abi, signer);
    return await pool.send('borrow',
        [params.address, params.amount, params.interstRateMode, 0, to]);
  } else {
    throw Exception('No wallet connected');
  }
}

Future<TransactionResponse> repay(RepayParams params) async {
  if (ethereum != null) {
    final signer = provider!.getSigner();
    final to = await signer.getAddress();
    final pool =
        Contract(Contracts.contracts(params.chainId)['pool'], pool_abi, signer);
    return await pool.send(
        'repay', [params.address, params.amount, params.interstRateMode, to]);
  } else {
    throw Exception('No wallet connected');
  }
}
