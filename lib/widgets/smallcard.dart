import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tlend_app/models/market.dart';
import 'package:tlend_app/widgets/market_card.dart';
import 'package:tlend_app/providers/store.dart';
import 'package:tlend_app/providers/utils.dart';

class YourSupplyCard extends StatefulWidget {
  final YourSupplyInfo info;

  const YourSupplyCard({
    super.key,
    required this.info,
  });
  @override
  State<YourSupplyCard> createState() => _YourSupplyCardState();
}

Widget _buildBase(widget, items) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.info.logo,
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.info.symbol,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.info.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      ...items
    ]),
  );
}

class _YourSupplyCardState extends State<YourSupplyCard> {
  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.balance,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatDecimal(widget.info.balance, false),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatDecimal(widget.info.balanceUSD, true),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.apy,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.info.apy.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.collateral,
            style: const TextStyle(fontSize: 16),
          ),
          Transform.scale(
            alignment: Alignment.centerRight,
            scale: 0.7,
            child: Switch(value: true, onChanged: (value) {}),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // widget.supply!(widget.info);
              },
              child: Text(AppLocalizations.of(context)!.supply),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: FilledButton(
              onPressed: () {
                // widget.withdraw!(widget.info);
              },
              // style: ButtonStyle(
              //   minimumSize: MaterialStateProperty.all(const Size(30, 40)),
              // ),
              child: Text(AppLocalizations.of(context)!.withdraw),
            ),
          ),
        ],
      ),
    ];
    return _buildBase(widget, children);
  }
}

class AssetsSupplyCard extends ConsumerStatefulWidget {
  final AssetsSupplyInfo info;

  const AssetsSupplyCard({
    super.key,
    required this.info,
  });
  @override
  ConsumerState<AssetsSupplyCard> createState() => _AssetsSupplyCardState();
}

class _AssetsSupplyCardState extends ConsumerState<AssetsSupplyCard> {
  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.walletBalance,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatDecimal(widget.info.balance, false),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatDecimal(widget.info.balanceUSD, true),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.apy,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.info.apy.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.canBeCollateral,
            style: const TextStyle(fontSize: 16),
          ),
          Transform.scale(
            alignment: Alignment.centerRight,
            scale: 0.7,
            child: Switch(value: true, onChanged: (value) {}),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // widget.supply!(widget.info);
              },
              child: Text(AppLocalizations.of(context)!.supply),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
              child: OutlinedButton(
            onPressed: () {
              ref.read(tabIndexProvider.notifier).changeTab(5);
              ref.read(reserveProvider.notifier).state = widget.info.assetInfo;
            },
            child: const Icon(Icons.more_horiz),
          )),
        ],
      ),
    ];
    return _buildBase(widget, children);
  }
}

class YourBorrowCard extends StatefulWidget {
  final YourBorrowInfo info;
  final Function(YourBorrowInfo info)? borrow;
  final Function(YourBorrowInfo info)? repay;

  const YourBorrowCard({
    super.key,
    required this.info,
    this.borrow,
    this.repay,
  });
  @override
  State<YourBorrowCard> createState() => _YourBorrowCardState();
}

class _YourBorrowCardState extends State<YourBorrowCard> {
  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.walletBalance,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatDecimal(widget.info.debt, false),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatDecimal(widget.info.debtUSD, true),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.apy,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.info.apy.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.apyType,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            widget.info.apyType,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                widget.borrow!(widget.info);
              },
              child: Text(AppLocalizations.of(context)!.supply),
            ),
          ),
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              widget.repay!(widget.info);
            },
            child: const Icon(Icons.more_horiz),
          )),
        ],
      ),
    ];
    return _buildBase(widget, children);
  }
}

class AssetsBorrowCard extends ConsumerStatefulWidget {
  final AssetsBorrowInfo info;

  const AssetsBorrowCard({
    super.key,
    required this.info,
  });
  @override
  ConsumerState<AssetsBorrowCard> createState() => _AssetsBorrowCardState();
}

class _AssetsBorrowCardState extends ConsumerState<AssetsBorrowCard> {
  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.avaliable,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatDecimal(widget.info.available, false),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatDecimal(widget.info.availableUSD, true),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.apyAndVariable,
            style: const TextStyle(fontSize: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.info.apy.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // widget.borrow!(widget.info);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 减小圆角大小
                ),
              ),
              child: Text(AppLocalizations.of(context)!.borrow),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
              child: OutlinedButton(
            onPressed: () {
              ref.read(tabIndexProvider.notifier).changeTab(5);
              ref.read(reserveProvider.notifier).state = widget.info.assetInfo;
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 减小圆角大小
              ),
            ),
            child: const Icon(Icons.more_horiz),
          )),
        ],
      ),
    ];
    return _buildBase(widget, children);
  }
}

class MarketSmallCard extends ConsumerStatefulWidget {
  final MarketInfo info;
  const MarketSmallCard({
    super.key,
    required this.info,
  });
  String get symbol => info.symbol;

  @override
  ConsumerState<MarketSmallCard> createState() => _MarketSmallCardState();
}

class _MarketSmallCardState extends ConsumerState<MarketSmallCard> {
  @override
  Widget build(BuildContext context) {
    final children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppLocalizations.of(context)!.totalSupplied,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDecimal(widget.info.totalSupplied, false),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  formatDecimal(widget.info.totalSuppliedUSD, true),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(AppLocalizations.of(context)!.supplyApy,
                style: const TextStyle(fontSize: 16)),
          ),
          Flexible(
            child: Text('${widget.info.supplyAPY.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(8),
        child: Divider(height: 1, color: Colors.grey),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppLocalizations.of(context)!.totalBorrowed,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatDecimal(widget.info.totalBorrowed, false),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  formatDecimal(widget.info.totalBorrowedUSD, true),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(AppLocalizations.of(context)!.borrowApyAndVariable,
                style: const TextStyle(fontSize: 16)),
          ),
          Flexible(
            child: Text('${widget.info.borrowAPY.shift(2).toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
      const SizedBox(height: 20),
      // Flexible(
      SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            ref.read(tabIndexProvider.notifier).changeTab(5);
            ref.read(reserveProvider.notifier).state = widget.info.assetInfo;
          },
          child: Text(AppLocalizations.of(context)!.details),
        ),
      ),
    ];
    return _buildBase(widget, children);
  }
}

Widget buildSmallCards(context, id, title, cards) {
  return MarketCard(
    id: id,
    title: title,
    small: true,
    info: const SizedBox(),
    smallColum: Column(
      children: [
        ...(cards
            .map((card) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: card,
                  ),
                ))
            .toList()),
      ],
    ),
  );
}

class SmallCardScreen extends ConsumerStatefulWidget {
  final String id;
  final String title;
  final List<Widget> cards;

  const SmallCardScreen({
    super.key,
    required this.id,
    required this.title,
    required this.cards,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SmallCardScreenState createState() => _SmallCardScreenState();
}

class _SmallCardScreenState extends ConsumerState<SmallCardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filteredCards = widget.cards.where((card) {
      final symbol = (card as dynamic).symbol.toString().toLowerCase();
      return symbol.contains(_searchText.toLowerCase());
    }).toList();

    final prefs = ref.watch(storeProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 点击其他地方时隐藏键盘
      },
      child: Card(
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
                  message: prefs.getBool('${widget.id}_hid') == null
                      ? AppLocalizations.of(context)!.show
                      : AppLocalizations.of(context)!.hide,
                  child: Transform.scale(
                      scale: 0.7,
                      child: Switch(
                          value: prefs.getBool('${widget.id}_hid') ?? false,
                          onChanged: (bool value) {
                            setState(() {});
                            prefs.setBool('${widget.id}_hid', value);
                          })),
                ),
              ],
            ),
            if (prefs.getBool('${widget.id}_hid') == null)
              const SizedBox()
            else
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 36,
                      child: TextField(
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          labelText: 'Search by symbol',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(12.0)), // 设置圆角半径
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ...(filteredCards
                          .map((card) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: card,
                                ),
                              ))
                          .toList()),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
