import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tlend_app/providers/utils.dart';
import 'package:tlend_app/providers/store.dart';
import 'package:tlend_app/screens/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(context) {
    final themeMode = ref.watch(brightnessProvider);
    final language = ref.watch(languageProvider);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(language),
      title: 'tlend app',
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      // home: const DashboardScreen(),
      home: const Layout(),
      // routes: {
      //   '/home': (context) => const DashboardScreen(),
      //   '/dashboard': (context) => const DashboardScreen(),
      //   '/markets': (context) => const MarketsScreen(),
      //   '/reserve': (context) => const ReserveScreen(),
      //   '/stakes': (context) => const ReserveScreen(),
      //   '/gov': (context) => const ReserveScreen(),
      // },
    );
  }
}
