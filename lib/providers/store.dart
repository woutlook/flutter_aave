import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

final storeProvider = StateProvider<SharedPreferences>((ref) {
  return sharedPreferences!;
});

Future<void> initializeSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
