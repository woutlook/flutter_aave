import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/providers/store.dart';
import 'package:tlend_app/providers/utils.dart';
import 'package:tlend_app/widgets/appbar.dart';
import 'package:tlend_app/screens/markets.dart';
import 'package:tlend_app/screens/dashboard.dart';
import 'package:tlend_app/screens/reserve.dart';
import 'package:url_launcher/url_launcher.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({
    super.key,
  });

  @override
  ConsumerState createState() => LayoutState();
}

class LayoutState extends ConsumerState<Layout> with TickerProviderStateMixin {
  List<Widget> _buildTabs(context) {
    return [
      InkWell(
        onTap: () {
          ref.read(tabIndexProvider.notifier).changeTab(0);
        },
        child: Tab(
          icon: const Icon(Icons.dashboard_outlined),
          text: AppLocalizations.of(context)!.dashboard,
          iconMargin: const EdgeInsets.only(bottom: 0.0),
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(tabIndexProvider.notifier).changeTab(1);
        },
        child: Tab(
          icon: const Icon(Icons.money_off_outlined),
          text: AppLocalizations.of(context)!.markets,
          iconMargin: const EdgeInsets.only(bottom: 0.0),
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(tabIndexProvider.notifier).changeTab(2);
        },
        child: Tab(
          icon: const Icon(Icons.food_bank_outlined),
          text: AppLocalizations.of(context)!.stake,
          iconMargin: const EdgeInsets.only(bottom: 0.0),
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(tabIndexProvider.notifier).changeTab(3);
        },
        child: Tab(
          icon: const Icon(Icons.how_to_vote_outlined),
          text: AppLocalizations.of(context)!.governance,
          iconMargin: const EdgeInsets.only(bottom: 0.0),
        ),
      ),
      InkWell(
        onTap: () {
          ref.read(tabIndexProvider.notifier).changeTab(4);
        },
        child: Tab(
          icon: const Icon(Icons.account_balance_outlined),
          text: AppLocalizations.of(context)!.more,
          iconMargin: const EdgeInsets.only(bottom: 0.0),
        ),
      ),
    ];
  }

  List<Widget> _buildActions(context) {
    final prefs = ref.watch(storeProvider);
    final currentAccount = ref.watch(walletAccountProvider);
    return [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: FilledButton.tonal(
          onPressed: () {
            if (kIsWeb) {
              ref.read(walletStateProvider.notifier).connect();
            } else {}
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 8.0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_circle),
              const SizedBox(width: 10),
              Text(
                currentAccount.isEmpty
                    ? AppLocalizations.of(context)!.connectWallet
                    : currentAccount.length > 8
                        ? '${currentAccount.substring(0, 4)}...${currentAccount.substring(currentAccount.length - 4)}'
                        : currentAccount,
              )
            ],
          ),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: AppLocalizations.of(context)!.toggleTestNetwork,
            child: Transform.scale(
              scale: 0.7,
              child: Switch(
                  value: prefs.getBool('isTest') ?? false,
                  onChanged: (value) {
                    setState(() {});
                    changeTestNetwork(value, ref);
                    prefs.setBool('isTest', value);
                  }),
            ),
          ),
          BrightnessButton(
            tooltipMessage: AppLocalizations.of(context)!.toggleBrightness,
          ),
          Tooltip(
            message: AppLocalizations.of(context)!.selectLanguage,
            child: _buildLanguageMenu(context),
          ),
        ],
      ),
    ];
  }

  Widget _buildLanguageMenu(context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          iconSize: 24,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.language_outlined),
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: SvgPicture.asset(
            'assets/icons/flags/en.svg',
          ),
          child: const Text('English '),
          onPressed: () {
            ref.read(languageProvider.notifier).state = 'en';
          },
        ),
        MenuItemButton(
          leadingIcon: SvgPicture.asset(
            'assets/icons/flags/cn.svg',
          ),
          child: const Text('中文 '),
          onPressed: () {
            ref.read(languageProvider.notifier).state = 'zh';
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);
    final tabs = _buildTabs(context);
    final actions = _buildActions(context);
    final appBar = MyAppBar(tabs: tabs, actions: actions);
    final drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ..._buildActions(context),
          const Divider(),
          ...tabs,
        ],
      ),
    );
    final body = IndexedStack(
      index: ref.watch(tabIndexProvider).index,
      children: const [
        DashboardScreen(),
        MarketsScreen(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
        ReserveScreen(),
      ],
    );
    final bottomNavigationBar = BottomAppBar(
      padding: const EdgeInsets.all(0),
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(icon: const Icon(Icons.home), onPressed: () => {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () => {}),
          const SizedBox(width: 16), // The dummy child for the notch
          IconButton(
            icon: const Icon(Bootstrap.github),
            onPressed: () async {
              final url = Uri.parse('https://github.com');
              if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
                throw 'Could not launch $url';
              }
            },
          ),
          IconButton(
            icon: const Icon(Bootstrap.twitter_x),
            onPressed: () async {
              final url = Uri.parse('https://twitter.com');
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );

    return Localizations.override(
      context: context,
      locale: Locale(language),
      child: Builder(builder: (context) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 880) {
            return Scaffold(
              drawer: drawer,
              body: Stack(
                children: [
                  body,
                  Builder(builder: (context) {
                    return Positioned(
                      top: 16,
                      left: 16,
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const Icon(Icons.menu),
                      ),
                    );
                  }),
                ],
              ),
              bottomNavigationBar: bottomNavigationBar,
            );
          } else {
            return Scaffold(
              appBar: appBar,
              drawer: drawer,
              body: body,
              bottomNavigationBar: bottomNavigationBar,
            );
          }
        });
      }),
    );
  }
}
