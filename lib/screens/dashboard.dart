import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tlend_app/widgets/network_menu.dart';
import 'package:tlend_app/widgets/table.dart';
import 'package:tlend_app/widgets/smallcard.dart';
import 'package:tlend_app/widgets/market_card.dart';
import 'package:tlend_app/widgets/tab.dart';

import 'package:tlend_app/config/const.dart';
import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/providers/appdata.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/models/market.dart';
import 'package:tlend_app/providers/store.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<DashboardScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final largeWidthBreakpoint = 1500;
  final mediumWidthBreakpoint = 720;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appData = ref.watch(appDataProvider);
    final body = appData.when(
      data: (data) => _build(context, data),
      loading: () => appDataCache == null
          ? const Center(child: CircularProgressIndicator())
          : _build(context, appDataCache),
      error: (error, stack) => Text(error.toString()),
    );
    // return Layout(body: body);
    return body;
  }

  Widget _build(context, appData) {
    final width = MediaQuery.of(context).size.width;
    final isTestnet = ref.watch(testNetworkProvider);
    final networks = isTestnet ? testNetworkList : networkList;

    if (width > largeWidthBreakpoint) {
      return _buildLargeScreen(context, networks, appData);
    } else if (width > mediumWidthBreakpoint) {
      return _buildMiddleScreen(context, networks, appData);
    } else {
      return _buildSmallScreen(context, networks, appData);
    }
  }

  List<Widget> _buildSupplies(appData) {
    final yourSupplies = getYourSupplyInfos(appData);
    final assetsSupplies = getAssetsSupplyInfos(appData, true);
    List<Widget> suppliesChildren = [
      colDivider,
      MarketCard(
        id: 'your_supplies_card',
        title: AppLocalizations.of(context)!.yourSupplies,
        info: const SizedBox(),
        table: buildYourSuppliesTable(context, ref, yourSupplies),
      ),
      colDivider,
      MarketCard(
        id: 'assets_supplies_card',
        title: AppLocalizations.of(context)!.assetsToSuppliy,
        info: const SizedBox(),
        table: buildAssetsSuppliesTable(context, ref, assetsSupplies),
      ),
    ];
    return suppliesChildren;
  }

  List<Widget> _buildBorrows(appData) {
    final yourBorrows = getYourBorrowInfos(appData);
    final assetsBorrows = getAssetsBorrowInfos(appData);
    List<Widget> borrowsChildren = [
      colDivider,
      MarketCard(
        id: 'your_borrows_card',
        title: AppLocalizations.of(context)!.yourBorrows,
        info: const SizedBox(),
        table: buildYourBorrowsTable(context, ref, yourBorrows),
      ),
      colDivider,
      MarketCard(
        id: 'assets_borrows_card',
        title: AppLocalizations.of(context)!.assetsToBorrow,
        info: const SizedBox(),
        table: buildAssetsBorrowsTable(context, ref, assetsBorrows),
      ),
    ];
    return borrowsChildren;
  }

  Widget _buildLargeScreen(context, networks, appData) {
    final suppliesChildren = _buildSupplies(appData);
    final borrowsChildren = _buildBorrows(appData);
    return Column(
      children: [
        const SizedBox(height: 10),
        buildNetworks(context, ref, networks),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(children: [...suppliesChildren]),
                ),
                const SizedBox(width: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(children: [...borrowsChildren]),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleScreen(context, networks, appData) {
    final supplies = _buildSupplies(appData);
    final borrows = _buildBorrows(appData);
    return _buildScreen(context, networks, supplies, borrows, false);
  }

  Widget _buildSmallScreen(context, networks, appData) {
    final yourSupplies = getYourSupplyInfos(appData);
    final assetsSupplies = getAssetsSupplyInfos(appData, true);
    final yourBorrows = getYourBorrowInfos(appData);
    final assetsBorrows = getAssetsBorrowInfos(appData);

    final yourSuppliesCards = yourSupplies
        .map(
          (info) => YourSupplyCard(
            info: info,
          ),
        )
        .toList();
    final assetsSupoliesCards = assetsSupplies
        .map(
          (info) => AssetsSupplyCard(
            info: info,
          ),
        )
        .toList();
    final yourBorrowsCards = yourBorrows
        .map(
          (info) => YourBorrowCard(
            info: info,
            borrow: (info) {},
            repay: (info) {},
          ),
        )
        .toList();
    final assetsBorrowsCards = assetsBorrows
        .map(
          (info) => AssetsBorrowCard(
            info: info,
          ),
        )
        .toList();
    final supplies = [
      buildSmallCards(context, 'your_supplies_card',
          AppLocalizations.of(context)!.yourSupplies, yourSuppliesCards),
      buildSmallCards(context, 'assets_supplies_card',
          AppLocalizations.of(context)!.assetsToSuppliy, assetsSupoliesCards)
    ];
    final borrows = [
      buildSmallCards(context, 'your_borrows_card',
          AppLocalizations.of(context)!.yourBorrows, yourBorrowsCards),
      buildSmallCards(context, 'assets_borrows_card',
          AppLocalizations.of(context)!.assetsToBorrow, assetsBorrowsCards)
    ];
    return _buildScreen(context, networks, supplies, borrows, true);
  }

  Widget _buildScreen(context, networks, supplies, borrows, isSmall) {
    final prefs = ref.watch(storeProvider);
    final initIndex = prefs.getInt('dashboard_tabIndex') ?? 0;
    final tabController =
        TabController(length: 2, vsync: this, initialIndex: initIndex);
    tabController.addListener(() {
      prefs.setInt('dashboard_tabIndex', tabController.index);
    });
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        buildNetworks(context, ref, networks),
        TabBar(
          controller: tabController,
          labelStyle: const TextStyle(fontSize: 20),
          indicator: GradientUnderlineTabIndicator(
            gradient: const LinearGradient(
                colors: [Colors.red, Colors.yellow, Colors.green]),
            width: 3,
          ),
          isScrollable: true,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.supply,
            ),
            Tab(
              text: AppLocalizations.of(context)!.borrow,
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              SingleChildScrollView(
                child: isSmall
                    ? Column(children: [...supplies])
                    : _buildTabViewMiddle(supplies),
              ),
              SingleChildScrollView(
                child: isSmall
                    ? Column(children: [...borrows])
                    : _buildTabViewMiddle(borrows),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabViewMiddle(items) {
    return Row(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 720,
          ),
          child: Column(
            children: [
              ...items,
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
