// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tlend_app/providers/reserve.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/providers/incentive.dart';
import 'package:tlend_app/providers/appdata.dart';

import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/models/reserve.dart';
import 'package:tlend_app/models/incentive.dart';
import 'package:tlend_app/models/appdata.dart';
import 'package:tlend_app/models/market.dart';

void main() {
  group('Reserve Providers', () {
    test(
        'reservesDataProvider calls web3Client with correct parameters and handles output',
        () async {
      final container = ProviderContainer();

      final value = await container.read(reservesDataProvider.future);
      expect(value, isA<ReservesData>());
      expect(value.reserves.length, equals(31));

      var encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(value);
      print(prettyPrint);
    });

    test(
        'userReservesDataProvider calls web3Client with correct parameters and handles output',
        () async {
      final container = ProviderContainer();
      container.read(walletAccountProvider.notifier).state =
          ('0x077A79ab65cAAbAa684f34Cc22aCa911742690E0');
      container.read(networkProvider.notifier).state = 11155111;

      final value = await container.read(userReservesDataProvider.future);
      expect(value, isA<UserReservesData>());
      expect(value.reserves.length, equals(9));

      var encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(value);
      print(prettyPrint);
    });

    test('incentivesProvider calls web3Client with correct parameters',
        () async {
      final container = ProviderContainer();

      final value = await container.read(incentivesProvider.future);
      expect(value, isA<List<AggregatedReserveIncentiveData>>());
      expect(value.length, equals(31));

      var encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(value);
      print(prettyPrint);
    });

    test('userIncenticeProvider test', () async {
      final container = ProviderContainer();
      container.read(walletAccountProvider.notifier).state =
          ('0x077A79ab65cAAbAa684f34Cc22aCa911742690E0');
      container.read(networkProvider.notifier).state = 11155111;

      final value = await container.read(userIncentivesProvider.future);
      expect(value, isA<List<UserReserveIncentiveData>>());
      expect(value.length, equals(9));

      var encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(value);
      print(prettyPrint);
    });

    test("appDataProvider test", () async {
      final container = ProviderContainer();
      container.read(walletAccountProvider.notifier).state =
          ('0x077A79ab65cAAbAa684f34Cc22aCa911742690E0');
      // container.read(networkProvider.notifier).state = 11155111;
      container.read(networkProvider.notifier).state = 1;

      final value = await container.read(appDataProvider.future);
      expect(value, isA<AppData>());

      var encoder = const JsonEncoder.withIndent('  ');

      final assetsSupplyItems = getAssetsSupplyInfos(value, true);
      var assetsSupplyItemsJson =
          assetsSupplyItems.map((item) => item.toJson()).toList();
      String prettyPrintAssetsSupply = encoder.convert(assetsSupplyItemsJson);
      print(prettyPrintAssetsSupply);

      final assetsBorrowItems = getAssetsBorrowInfos(value);
      var assetsBorrowItemsJson =
          assetsBorrowItems.map((item) => item.toJson()).toList();
      var prettyPrintAssetsBorrow = encoder.convert(assetsBorrowItemsJson);
      print(prettyPrintAssetsBorrow);

      final yourSupplyItems = getYourSupplyInfos(value);
      var yourSupplyItemsJson =
          yourSupplyItems.map((item) => item.toJson()).toList();
      var prettyPrintYourSupply = encoder.convert(yourSupplyItemsJson);
      print(prettyPrintYourSupply);

      final yourBorrowItems = getYourBorrowInfos(value);
      var yourBorrowItemsJson =
          yourBorrowItems.map((item) => item.toJson()).toList();
      var prettyPrintYourBorrow = encoder.convert(yourBorrowItemsJson);
      print(prettyPrintYourBorrow);
    });
  });
}
