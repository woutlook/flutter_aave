import 'package:decimal/decimal.dart';
import 'package:tlend_app/math/incentive.dart';
import 'package:tlend_app/math/reserve.dart';
import 'package:tlend_app/math/user.dart';
import 'package:tlend_app/config/tokens.dart';

class WalletBalance {
  final String symbol;
  final Decimal balance;
  final Decimal balanceUSD;

  WalletBalance(
      {required this.symbol, required this.balance, required this.balanceUSD});

  Map<String, dynamic> toJson() {
    return {
      'address': symbol,
      'balance': balance.toString(),
      'balanceUSD': balanceUSD.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class AppData {
  final List<FormatReserveUSDResponse> reserves;
  final Map<String, ReserveIncentives> incentives;
  final FormatUserSummaryResponse userReserves;
  final Map<String, FormatedUserIncentiveData> userIncentives;
  final Map<String, WalletBalance> userBalances;
  final Map<String, Token?> tokens;
  final BigInt marketReferencePriceInUsd;
  final int marketReferenceCurrencyDecimals;
  // final bool isTestnet;

  AppData({
    required this.reserves,
    required this.incentives,
    required this.userReserves,
    required this.userIncentives,
    required this.userBalances,
    required this.tokens,
    required this.marketReferencePriceInUsd,
    required this.marketReferenceCurrencyDecimals,
    // required this.isTestnet,
  });

  Map<String, dynamic> toJson() {
    return {
      'reserves': reserves.map((reserve) => reserve.toJson()).toList(),
      'incentives':
          incentives.map((key, value) => MapEntry(key, value.toJson())),
      'userReserves': userReserves.toJson(),
      'userIncentives':
          userIncentives.map((key, value) => MapEntry(key, value.toJson())),
      'userBalances':
          userBalances.map((key, value) => MapEntry(key, value.toJson())),
      'tokens': tokens.map((key, value) => MapEntry(key, value?.toJson())),
      'marketReferencePriceInUsd': marketReferencePriceInUsd.toString(),
      'marketReferenceCurrencyDecimals':
          marketReferenceCurrencyDecimals.toString(),
      // 'isTestnet': isTestnet,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
