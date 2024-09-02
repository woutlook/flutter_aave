import 'package:decimal/decimal.dart';
import 'package:tlend_app/models/appdata.dart';

class AssetInfo {
  final String address;
  final String logo;
  final String name;
  final String symbol;

  const AssetInfo(
      {required this.address,
      required this.logo,
      required this.name,
      required this.symbol});

  AssetInfo get assetInfo => AssetInfo(
        address: address,
        logo: logo,
        name: name,
        symbol: symbol,
      );
}

class YourSupplyInfo extends AssetInfo {
  final Decimal balance;
  final Decimal balanceUSD;
  final Decimal apy;
  final bool collateral;

  const YourSupplyInfo(
      {required super.logo,
      required super.name,
      required super.symbol,
      required this.balance,
      required this.balanceUSD,
      required this.apy,
      required this.collateral,
      required super.address});

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'name': name,
      'symbol': symbol,
      'balance': balance,
      'balanceUSD': balanceUSD,
      'apy': apy,
      'collateral': collateral,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class AssetsSupplyInfo extends AssetInfo {
  final Decimal balance;
  final Decimal balanceUSD;
  final Decimal apy;
  final bool collateral;

  const AssetsSupplyInfo(
      {required super.logo,
      required super.name,
      required super.symbol,
      required super.address,
      required this.balance,
      required this.balanceUSD,
      required this.apy,
      required this.collateral});

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'name': name,
      'symbol': symbol,
      'balance': balance,
      'balanceUSD': balanceUSD,
      'apy': apy,
      'collateral': collateral,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class YourBorrowInfo extends AssetInfo {
  final Decimal debt;
  final Decimal debtUSD;
  final Decimal apy;
  final String apyType;

  const YourBorrowInfo(
      {required super.name,
      required super.symbol,
      required super.logo,
      required super.address,
      required this.debt,
      required this.debtUSD,
      required this.apy,
      required this.apyType});

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'name': name,
      'symbol': symbol,
      'debt': debt,
      'debtUSD': debtUSD,
      'apy': apy,
      'apyType': apyType,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class AssetsBorrowInfo extends AssetInfo {
  final Decimal available;
  final Decimal availableUSD;
  final Decimal apy;

  const AssetsBorrowInfo({
    required super.name,
    required super.symbol,
    required super.logo,
    required super.address,
    required this.available,
    required this.availableUSD,
    required this.apy,
  });

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'name': name,
      'symbol': symbol,
      'available': available,
      'availableUSD': availableUSD,
      'apy': apy,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class MarketInfo extends AssetInfo {
  final Decimal totalSupplied;
  final Decimal totalSuppliedUSD;
  final Decimal supplyAPY;
  final Decimal totalBorrowed;
  final Decimal totalBorrowedUSD;
  final Decimal borrowAPY;

  const MarketInfo(
      {required super.name,
      required super.symbol,
      required super.logo,
      required super.address,
      required this.totalSupplied,
      required this.totalSuppliedUSD,
      required this.supplyAPY,
      required this.totalBorrowed,
      required this.totalBorrowedUSD,
      required this.borrowAPY});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
      'logo': logo,
      'totalSupplied': totalSupplied,
      'totalSuppliedUSD': totalSuppliedUSD,
      'supplyAPY': supplyAPY,
      'totalBorrowed': totalBorrowed,
      'totalBorrowedUSD': totalBorrowedUSD,
      'borrowAPY': borrowAPY,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

List<YourSupplyInfo> getYourSupplyInfos(AppData appData) {
  final userReserves = appData.userReserves.userReserves.where((reserve) {
    return reserve.underlyingBalance > Decimal.zero;
  }).toList();

  final reserveList = userReserves.map((reserve) {
    final ar = reserve.reserve.reserve;
    return YourSupplyInfo(
        name: ar.name,
        symbol: ar.symbol,
        address: ar.underlyingAsset.hex,
        logo: 'assets/icons/tokens/${ar.symbol.toLowerCase()}.svg}',
        apy: reserve.reserve.supplyAPY,
        balance: reserve.underlyingBalance,
        balanceUSD: reserve.underlyingBalanceUSD,
        collateral: reserve.reserve.reserve.usageAsCollateralEnabled);
  }).toList();
  return reserveList;
}

List<AssetsSupplyInfo> getAssetsSupplyInfos(
    AppData appData, bool showBalance0) {
  final balances = appData.userBalances;
  final reserves = appData.reserves.where((e) {
    if (!showBalance0) {
      final r = e.formatedRreserve.reserve;
      return balances[r.symbol] != null &&
          balances[r.symbol]!.balance > Decimal.zero &&
          r.symbol != 'GHO';
    } else {
      return true;
    }
  }).toList();
  final list = reserves.map((e) {
    final reserve = e.formatedRreserve;
    return AssetsSupplyInfo(
        name: reserve.reserve.name,
        symbol: reserve.reserve.symbol,
        address: reserve.reserve.underlyingAsset.hex,
        logo: 'assets/icons/tokens/${reserve.reserve.symbol.toLowerCase()}.svg',
        apy: reserve.supplyAPY,
        balance: balances[reserve.reserve.symbol]!.balance,
        balanceUSD: balances[reserve.reserve.symbol]!.balanceUSD,
        collateral: reserve.reserve.usageAsCollateralEnabled);
  }).toList();
  return list;
}

List<YourBorrowInfo> getYourBorrowInfos(AppData appData) {
  final userReserves = appData.userReserves.userReserves.where((e) {
    return e.variableBorrows > Decimal.zero || e.stableBorrows > Decimal.zero;
  }).toList();
  final list = userReserves.map((reserve) {
    final borrowAPY = reserve.variableBorrows > Decimal.zero
        ? reserve.reserve.variableBorrowAPY
        : reserve.reserve.stableBorrowAPY;
    final debt = reserve.variableBorrows > Decimal.zero
        ? reserve.variableBorrows
        : reserve.stableBorrows;
    final debtUSD = reserve.variableBorrows > Decimal.zero
        ? reserve.variableBorrowsUSD
        : reserve.stableBorrowsUSD;

    final ar = reserve.reserve.reserve;
    return YourBorrowInfo(
        name: ar.name,
        symbol: ar.symbol,
        address: ar.underlyingAsset.hex,
        logo: 'assets/icons/tokens/${ar.symbol.toLowerCase()}.svg',
        apy: borrowAPY,
        debt: debt,
        debtUSD: debtUSD,
        apyType: 'Variable');
  }).toList();
  return list;
}

List<AssetsBorrowInfo> getAssetsBorrowInfos(AppData appData) {
  final reserves = appData.reserves;
  final user =
      appData.userReserves; // .availableBorrowsMarketReferenceCurrency;
  final list = reserves.map((e) {
    final reserve = e.formatedRreserve;
    final availableBorrowCap = reserve.reserve.borrowCap == BigInt.zero
        ? BigInt.two.pow(256)
        : reserve.reserve.borrowCap - reserve.totalDebt.toBigInt();
    final availableLiquidity =
        reserve.formattedAvailableLiquidity < availableBorrowCap.toDecimal()
            ? reserve.formattedAvailableLiquidity
            : availableBorrowCap.toDecimal();
    final a = (user.availableBorrowsMarketReferenceCurrency /
            e.formattedPriceInMarketReferenceCurrency)
        .toDecimal(scaleOnInfinitePrecision: 2);
    var maxBorrow = availableLiquidity < a ? availableLiquidity : a;
    maxBorrow = maxBorrow * Decimal.parse('0.99');
    final maxBorrowUSD =
        (maxBorrow * appData.marketReferencePriceInUsd.toDecimal())
            .shift(-appData.marketReferenceCurrencyDecimals);

    return AssetsBorrowInfo(
        name: reserve.reserve.name,
        symbol: reserve.reserve.symbol,
        address: reserve.reserve.underlyingAsset.hex,
        logo: 'assets/icons/tokens/${reserve.reserve.symbol.toLowerCase()}.svg',
        apy: reserve.variableBorrowAPY,
        available: maxBorrow,
        availableUSD: maxBorrowUSD);
  }).toList();
  return list;
}

List<MarketInfo> getMarketInfos(AppData appData) {
  final reserves = appData.reserves;
  final list = reserves.map((e) {
    final reserve = e.formatedRreserve;
    return MarketInfo(
      name: reserve.reserve.name,
      symbol: reserve.reserve.symbol,
      address: reserve.reserve.underlyingAsset.hex,
      logo: 'assets/icons/tokens/${reserve.reserve.symbol.toLowerCase()}.svg',
      totalSupplied: reserve.totalLiquidity,
      totalSuppliedUSD: e.totalLiquidityUSD,
      supplyAPY: reserve.supplyAPY,
      totalBorrowed: reserve.totalDebt,
      totalBorrowedUSD: e.totalDebtUSD,
      borrowAPY: reserve.variableBorrowAPY,
    );
  }).toList();
  return list;
}

String formatDecimal(Decimal d, bool usd) {
  final s = d > 1000000000.toDecimal()
      ? '${d.shift(-9).toStringAsFixed(2)}B'
      : d > 1000000.toDecimal()
          ? '${d.shift(-6).toStringAsFixed(2)}M'
          : d > 1000.toDecimal()
              ? '${d.shift(-3).toStringAsFixed(2)}K'
              : d.toStringAsFixed(2);
  return usd ? '\$$s' : s;
}
