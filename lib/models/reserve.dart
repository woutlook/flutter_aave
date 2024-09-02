import 'package:web3dart/web3dart.dart';

class AggregatedReserveData {
  final EthereumAddress underlyingAsset;
  final String name;
  final String symbol;
  final BigInt decimals;
  final BigInt baseLTVasCollateral;
  final BigInt reserveLiquidationThreshold;
  final BigInt reserveLiquidationBonus;
  final BigInt reserveFactor;
  final bool usageAsCollateralEnabled;
  final bool borrowingEnabled;
  final bool stableBorrowRateEnabled;
  final bool isActive;
  final bool isFrozen;
  final BigInt liquidityIndex;
  final BigInt variableBorrowIndex;
  final BigInt liquidityRate;
  final BigInt variableBorrowRate;
  final BigInt stableBorrowRate;
  final BigInt lastUpdateTimestamp;
  final EthereumAddress aTokenAddress;
  final EthereumAddress stableDebtTokenAddress;
  final EthereumAddress variableDebtTokenAddress;
  final EthereumAddress interestRateStrategyAddress;
  final BigInt availableLiquidity;
  final BigInt totalPrincipalStableDebt;
  final BigInt averageStableRate;
  final BigInt stableDebtLastUpdateTimestamp;
  final BigInt totalScaledVariableDebt;
  final BigInt priceInMarketReferenceCurrency;
  final EthereumAddress priceOracle;
  final BigInt variableRateSlope1;
  final BigInt variableRateSlope2;
  final BigInt stableRateSlope1;
  final BigInt stableRateSlope2;
  final BigInt baseStableBorrowRate;
  final BigInt baseVariableBorrowRate;
  final BigInt optimalUsageRatio;
  final bool isPaused;
  final bool isSiloedBorrowing;
  final BigInt accruedToTreasury;
  final BigInt unbacked;
  final BigInt isolationModeTotalDebt;
  final bool flashLoanEnabled;
  final BigInt debtCeiling;
  final BigInt debtCeilingDecimals;
  final BigInt eModeCategoryId;
  final BigInt borrowCap;
  final BigInt supplyCap;
  final BigInt eModeLtv;
  final BigInt eModeLiquidationThreshold;
  final BigInt eModeLiquidationBonus;
  final EthereumAddress eModePriceSource;
  final String eModeLabel;
  final bool borrowableInIsolation;

  AggregatedReserveData(dynamic data)
      : underlyingAsset = data[0],
        name = data[1],
        symbol = data[2],
        decimals = data[3],
        baseLTVasCollateral = data[4],
        reserveLiquidationThreshold = data[5],
        reserveLiquidationBonus = data[6],
        reserveFactor = data[7],
        usageAsCollateralEnabled = data[8],
        borrowingEnabled = data[9],
        stableBorrowRateEnabled = data[10],
        isActive = data[11],
        isFrozen = data[12],
        liquidityIndex = data[13],
        variableBorrowIndex = data[14],
        liquidityRate = data[15],
        variableBorrowRate = data[16],
        stableBorrowRate = data[17],
        lastUpdateTimestamp = data[18],
        aTokenAddress = data[19],
        stableDebtTokenAddress = data[20],
        variableDebtTokenAddress = data[21],
        interestRateStrategyAddress = data[22],
        availableLiquidity = data[23],
        totalPrincipalStableDebt = data[24],
        averageStableRate = data[25],
        stableDebtLastUpdateTimestamp = data[26],
        totalScaledVariableDebt = data[27],
        priceInMarketReferenceCurrency = data[28],
        priceOracle = data[29],
        variableRateSlope1 = data[30],
        variableRateSlope2 = data[31],
        stableRateSlope1 = data[32],
        stableRateSlope2 = data[33],
        baseStableBorrowRate = data[34],
        baseVariableBorrowRate = data[35],
        optimalUsageRatio = data[36],
        isPaused = data[37],
        isSiloedBorrowing = data[38],
        accruedToTreasury = data[39],
        unbacked = data[40],
        isolationModeTotalDebt = data[41],
        flashLoanEnabled = data[42],
        debtCeiling = data[43],
        debtCeilingDecimals = data[44],
        eModeCategoryId = data[45],
        borrowCap = data[46],
        supplyCap = data[47],
        eModeLtv = data[48],
        eModeLiquidationThreshold = data[49],
        eModeLiquidationBonus = data[50],
        eModePriceSource = data[51],
        eModeLabel = data[52],
        borrowableInIsolation = data[53];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'underlyingAsset': underlyingAsset.toString(),
      'name': name,
      'symbol': symbol,
      'decimals': decimals.toInt(),
      'baseLTVasCollateral': baseLTVasCollateral.toString(),
      'reserveLiquidationThreshold': reserveLiquidationThreshold.toString(),
      'reserveLiquidationBonus': reserveLiquidationBonus.toString(),
      'reserveFactor': reserveFactor.toString(),
      'usageAsCollateralEnabled': usageAsCollateralEnabled,
      'borrowingEnabled': borrowingEnabled,
      'stableBorrowRateEnabled': stableBorrowRateEnabled,
      'isActive': isActive,
      'isFrozen': isFrozen,
      'liquidityIndex': liquidityIndex.toString(),
      'variableBorrowIndex': variableBorrowIndex.toString(),
      'liquidityRate': liquidityRate.toString(),
      'variableBorrowRate': variableBorrowRate.toString(),
      'stableBorrowRate': stableBorrowRate.toString(),
      'lastUpdateTimestamp': lastUpdateTimestamp.toString(),
      'aTokenAddress': aTokenAddress.toString(),
      'stableDebtTokenAddress': stableDebtTokenAddress.toString(),
      'variableDebtTokenAddress': variableDebtTokenAddress.toString(),
      'interestRateStrategyAddress': interestRateStrategyAddress.toString(),
      'availableLiquidity': availableLiquidity.toString(),
      'totalPrincipalStableDebt': totalPrincipalStableDebt.toString(),
      'averageStableRate': averageStableRate.toString(),
      'stableDebtLastUpdateTimestamp': stableDebtLastUpdateTimestamp.toString(),
      'totalScaledVariableDebt': totalScaledVariableDebt.toString(),
      'priceInMarketReferenceCurrency':
          priceInMarketReferenceCurrency.toString(),
      'priceOracle': priceOracle.toString(),
      'variableRateSlope1': variableRateSlope1.toString(),
      'variableRateSlope2': variableRateSlope2.toString(),
      'stableRateSlope1': stableRateSlope1.toString(),
      'stableRateSlope2': stableRateSlope2.toString(),
      'baseStableBorrowRate': baseStableBorrowRate.toString(),
      'baseVariableBorrowRate': baseVariableBorrowRate.toString(),
      'optimalUsageRatio': optimalUsageRatio.toString(),
      'isPaused': isPaused,
      'isSiloedBorrowing': isSiloedBorrowing,
      'accruedToTreasury': accruedToTreasury.toString(),
      'unbacked': unbacked.toString(),
      'isolationModeTotalDebt': isolationModeTotalDebt.toString(),
      'flashLoanEnabled': flashLoanEnabled,
      'debtCeiling': debtCeiling.toString(),
      'debtCeilingDecimals': debtCeilingDecimals.toString(),
      'eModeCategoryId': eModeCategoryId.toString(),
      'borrowCap': borrowCap.toString(),
      'supplyCap': supplyCap.toString(),
      'eModeLtv': eModeLtv.toString(),
      'eModeLiquidationThreshold': eModeLiquidationThreshold.toString(),
      'eModeLiquidationBonus': eModeLiquidationBonus.toString(),
      'eModePriceSource': eModePriceSource.toString(),
      'eModeLabel': eModeLabel,
      'borrowableInIsolation': borrowableInIsolation,
    };
  }
}

class BaseCurrencyInfo {
  final BigInt marketReferenceCurrencyUnit;
  final BigInt marketReferenceCurrencyPriceInUsd;
  final BigInt networkBaseTokenPriceInUsd;
  final BigInt networkBaseTokenPriceDecimals;

  BaseCurrencyInfo(dynamic data)
      : marketReferenceCurrencyUnit = data[0],
        marketReferenceCurrencyPriceInUsd = data[1],
        networkBaseTokenPriceInUsd = data[2],
        networkBaseTokenPriceDecimals = data[3];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'marketReferenceCurrencyUnit': marketReferenceCurrencyUnit.toString(),
      'marketReferenceCurrencyPriceInUsd':
          marketReferenceCurrencyPriceInUsd.toString(),
      'networkBaseTokenPriceInUsd': networkBaseTokenPriceInUsd.toString(),
      'networkBaseTokenPriceDecimals': networkBaseTokenPriceDecimals.toString(),
    };
  }
}

class ReservesData {
  late List<AggregatedReserveData> reserves;
  late BaseCurrencyInfo baseCurrencyInfo;

  ReservesData(List<dynamic> data)
      : reserves = (data[0] as List<dynamic>)
            .map((item) => AggregatedReserveData(item))
            .toList(),
        baseCurrencyInfo = BaseCurrencyInfo(data[1]);

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'reserves': reserves.map((item) => item.toJson()).toList(),
      'baseCurrencyInfo': baseCurrencyInfo.toJson(),
    };
  }
}

class UserReserveData {
  final EthereumAddress underlyingAsset;
  final BigInt scaledATokenBalance;
  final bool usageAsCollateralEnabledOnUser;
  final BigInt stableBorrowRate;
  final BigInt scaledVariableDebt;
  final BigInt principalStableDebt;
  final BigInt stableBorrowLastUpdateTimestamp;

  UserReserveData(dynamic data)
      : underlyingAsset = data[0],
        scaledATokenBalance = data[1],
        usageAsCollateralEnabledOnUser = data[2],
        stableBorrowRate = data[3],
        scaledVariableDebt = data[4],
        principalStableDebt = data[5],
        stableBorrowLastUpdateTimestamp = data[6];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'underlyingAsset': underlyingAsset.toString(),
      'scaledATokenBalance': scaledATokenBalance.toString(),
      'usageAsCollateralEnabledOnUser': usageAsCollateralEnabledOnUser,
      'stableBorrowRate': stableBorrowRate.toString(),
      'scaledVariableDebt': scaledVariableDebt.toString(),
      'principalStableDebt': principalStableDebt.toString(),
      'stableBorrowLastUpdateTimestamp':
          stableBorrowLastUpdateTimestamp.toString(),
    };
  }
}

class UserReservesData {
  late List<UserReserveData> reserves;
  late BigInt userEmodeCategoryId;

  UserReservesData(List<dynamic> data)
      : reserves = (data[0] as List<dynamic>)
            .map((item) => UserReserveData(item))
            .toList(),
        userEmodeCategoryId = data[1];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'reserves': reserves.map((item) => item).toList(),
      'userEmodeCategoryId': userEmodeCategoryId.toString(),
    };
  }
}
