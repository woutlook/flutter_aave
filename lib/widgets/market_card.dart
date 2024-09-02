import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tlend_app/widgets/sliver.dart';
import 'package:tlend_app/config/const.dart';
import 'package:tlend_app/providers/store.dart';

class MarketCard extends ConsumerStatefulWidget {
  const MarketCard(
      {super.key,
      required this.id,
      required this.title,
      this.small = false,
      required this.info,
      this.table,
      this.smallColum});
  final String id;
  final String title;
  final bool small;
  final Widget info;
  final Widget? smallColum;
  final Widget? table;

  @override
  ConsumerState<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends ConsumerState<MarketCard> {
  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(storeProvider);
    final hid = prefs.getBool('${widget.id}_hid') ?? false;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Expanded(child: Container()),
              Tooltip(
                message: hid
                    ? AppLocalizations.of(context)!.show
                    : AppLocalizations.of(context)!.hide,
                child: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                        value: hid,
                        onChanged: (bool value) {
                          setState(() {});
                          prefs.setBool('${widget.id}_hid', value);
                        })),
              ),
            ],
          ),
          // widget.info,
          if (!hid) widget.small ? widget.smallColum! : widget.table!,
        ],
      ),
    );
  }
}

Widget buildCart(List<Widget> children) {
  List<double?> heights = List.filled(children.length, null);

  // Fully traverse this list before moving on.
  return FocusTraversalGroup(
    child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.only(end: smallSpacing),
          sliver: SliverList(
            delegate: BuildSlivers(
              heights: heights,
              builder: (context, index) {
                return CacheHeight(
                  heights: heights,
                  index: index,
                  child: children[index],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
