class WalletState {
  String currentNetwork;
  String currentChain;
  String currentAccount;
  bool connected = false;

  WalletState({
    required this.currentNetwork,
    required this.currentChain,
    required this.currentAccount,
    required this.connected,
  });
}

class SupplyParams {
  final int chainId;
  final String address;
  final BigInt amount;

  SupplyParams({
    required this.chainId,
    required this.address,
    required this.amount,
  });
}

class WithdrawParams {
  final int chainId;
  final String address;
  final BigInt amount;

  WithdrawParams({
    required this.chainId,
    required this.address,
    required this.amount,
  });
}

class BorrowParams {
  final int chainId;
  final String address;
  final BigInt amount;
  final BigInt interstRateMode;

  BorrowParams({
    required this.chainId,
    required this.address,
    required this.amount,
    required this.interstRateMode,
  });
}

class RepayParams {
  final int chainId;
  final String address;
  final BigInt amount;
  final BigInt interstRateMode;

  RepayParams({
    required this.chainId,
    required this.address,
    required this.amount,
    required this.interstRateMode,
  });
}
