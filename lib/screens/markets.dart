import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tlend_app/models/market.dart';

import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/providers/appdata.dart';
import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/widgets/market_card.dart';
import 'package:tlend_app/widgets/network_menu.dart';
import 'package:tlend_app/widgets/smallcard.dart';
import 'package:tlend_app/widgets/table.dart';

class MarketsScreen extends ConsumerStatefulWidget {
  const MarketsScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _MarketsState();
}

class _MarketsState extends ConsumerState<MarketsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appData = ref.watch(appDataProvider);

    final body = appData.when(data: (data) {
      return _build(context, data);
    }, loading: () {
      return Center(
        child: appDataCache == null
            ? const CircularProgressIndicator()
            : _build(context, appDataCache),
      );
    }, error: (error, stack) {
      return Text(error.toString());
    });

    return body;
  }

  Widget _build(context, appData) {
    super.build(context);
    final isTestnet = ref.watch(testNetworkProvider);
    final networks = isTestnet ? testNetworkList : networkList;
    final title =
        '${networks[0].chainName} ${AppLocalizations.of(context)!.markets}';
    final items = getMarketInfos(appData);
    final small = MediaQuery.of(context).size.width < 1000;
    final table = small ? null : buildMarketTable(context, ref, items);
    final card = small
        ? SmallCardScreen(
            id: 'markets',
            title: title,
            cards: items.map((e) => MarketSmallCard(info: e)).toList())
        : MarketCard(
            id: 'markets',
            title:
                '${networks[0].chainName} ${AppLocalizations.of(context)!.markets}',
            info: const SizedBox(),
            small: small,
            table: table,
          );

    return SizedBox(
      child: Column(
        children: [
          buildNetworks(context, ref, networks),
          Flexible(
              child: SingleChildScrollView(
            child: small
                ? card
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: card,
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
          )),
        ],
      ),
    );
  }
}
