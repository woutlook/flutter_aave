import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tlend_app/models/market.dart';

class TabIndex {
  int index;
  int prev;
  TabIndex({required this.index, required this.prev});
}

class TabIndexNotifier extends StateNotifier<TabIndex> {
  TabIndexNotifier() : super(TabIndex(index: 0, prev: 0));

  void goback() {
    state = TabIndex(index: state.prev, prev: state.prev);
  }

  void changeTab(int index) {
    state = TabIndex(index: index, prev: state.index);
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndexNotifier, TabIndex>((ref) {
  return TabIndexNotifier();
});

final languageProvider = StateProvider<String>((ref) {
  return 'en';
});

final brightnessProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final reserveProvider = StateProvider<AssetInfo>((ref) {
  return const AssetInfo(
    name: 'USDC',
    address: '0x',
    logo: '',
    symbol: 'USDC',
  );
});
