import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tlend_app/providers/store.dart';
import 'package:tlend_app/providers/utils.dart';
import 'package:tlend_app/models/market.dart';

class ColumnDefinition<T> {
  final String label;
  final bool numeric;
  final Comparable Function(T)? getField;
  final Widget Function(T) buildCell;

  ColumnDefinition({
    required this.label,
    required this.numeric,
    this.getField,
    required this.buildCell,
  });
}

class SortableTable<T> extends ConsumerStatefulWidget {
  final List<T> items;
  final List<ColumnDefinition<T>> columns;
  final String id;

  const SortableTable({
    super.key,
    required this.items,
    required this.columns,
    required this.id,
  });

  @override
  SortableTableState<T> createState() => SortableTableState<T>();
}

class SortableTableState<T> extends ConsumerState<SortableTable<T>> {
  void _sort(int columnIndex, bool ascending) {
    final column = widget.columns[columnIndex];
    if (column.getField == null) return;
    widget.items.sort((a, b) {
      if (!ascending) {
        final T c = a;
        a = b;
        b = c;
      }
      final Comparable aValue = column.getField!(a);
      final Comparable bValue = column.getField!(b);
      return Comparable.compare(aValue, bValue);
    });
    final prefs = ref.watch(storeProvider);
    prefs.setInt('${widget.id}_index', columnIndex);
    prefs.setBool('${widget.id}_asc', ascending);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(storeProvider);
    final sortColumnIndex = prefs.getInt('${widget.id}_index') ?? 0;
    final sortAscending = prefs.getBool('${widget.id}_asc') ?? true;
    _sort(sortColumnIndex, sortAscending);
    return DataTable(
      dataRowMaxHeight: 64,
      dataRowMinHeight: 64,
      columnSpacing: 30,
      horizontalMargin: 10,
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
      columns: widget.columns.asMap().entries.map((entry) {
        ColumnDefinition column = entry.value;
        return DataColumn(
          label: Text(column.label),
          numeric: column.numeric,
          onSort: (columnIndex, ascending) => _sort(columnIndex, ascending),
        );
      }).toList(),
      rows: widget.items.map((item) {
        return DataRow(
          cells: widget.columns.map((column) {
            return DataCell(
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500, // Adjust the maxWidth as needed
                ),
                child: column.buildCell(item),
              ),
            ); // column.buildCell(item));
          }).toList(),
        );
      }).toList(),
    );
  }
}

Widget buildYourSuppliesTable(context, ref, items) {
  return SortableTable(
    id: 'your_supplies_table',
    items: items,
    columns: [
      ColumnDefinition<YourSupplyInfo>(
        label: AppLocalizations.of(context)!.asset,
        numeric: false,
        getField: (asset) => asset.symbol,
        buildCell: (asset) => Row(
          children: [
            SvgPicture.asset(
              asset.logo,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(asset.symbol,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ColumnDefinition<YourSupplyInfo>(
          label: AppLocalizations.of(context)!.balance,
          numeric: true,
          getField: (asset) => asset.balanceUSD,
          buildCell: (asset) {
            final balance = formatDecimal(asset.balance, false);
            final balanceUSD = formatDecimal(asset.balanceUSD, true);
            return SizedBox(
              width: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(balance),
                  Text(balanceUSD, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }),
      ColumnDefinition<YourSupplyInfo>(
          label: AppLocalizations.of(context)!.apy,
          numeric: true,
          getField: (asset) => asset.apy,
          buildCell: (asset) =>
              Text('${asset.apy.shift(2).toStringAsFixed(2)}%')),
      ColumnDefinition<YourSupplyInfo>(
        label: AppLocalizations.of(context)!.collateral,
        numeric: false,
        getField: (asset) => asset.collateral ? 'true' : 'false',
        buildCell: (asset) => SizedBox(
          width: 20,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(value: false, onChanged: (value) {}),
          ),
        ),
      ),
      ColumnDefinition<YourSupplyInfo>(
        label: '',
        numeric: false,
        buildCell: (asset) => Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.supply,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.withdraw),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildYourBorrowsTable(context, ref, items) {
  return SortableTable(
    id: 'your_borrows_table',
    items: items,
    columns: [
      ColumnDefinition<YourBorrowInfo>(
        label: AppLocalizations.of(context)!.asset,
        numeric: false,
        getField: (asset) => asset.symbol,
        buildCell: (asset) => Row(
          children: [
            SvgPicture.asset(
              asset.logo,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(asset.symbol,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ColumnDefinition<YourBorrowInfo>(
          label: AppLocalizations.of(context)!.debt,
          numeric: true,
          getField: (asset) => asset.debt,
          buildCell: (asset) {
            final debt = formatDecimal(asset.debt, false);
            final debtUSD = formatDecimal(asset.debtUSD, true);
            return SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(debt),
                  Text(debtUSD, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }),
      ColumnDefinition<YourBorrowInfo>(
          label: AppLocalizations.of(context)!.apy,
          numeric: true,
          getField: (asset) => asset.apy,
          buildCell: (asset) => SizedBox(
              width: 100,
              child: Text('${asset.apy.shift(2).toStringAsFixed(2)}%'))),
      ColumnDefinition<YourBorrowInfo>(
          label: AppLocalizations.of(context)!.apyType,
          numeric: false,
          getField: (asset) => asset.apyType,
          buildCell: (asset) =>
              SizedBox(width: 100, child: Text(asset.apyType))),
      ColumnDefinition<YourBorrowInfo>(
        label: '',
        numeric: false,
        buildCell: (asset) => Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.borrow,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.repay),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildAssetsBorrowsTable(context, ref, items) {
  return SortableTable(
    id: 'assets_borrows_table',
    items: items,
    columns: [
      ColumnDefinition<AssetsBorrowInfo>(
        label: AppLocalizations.of(context)!.asset,
        numeric: false,
        getField: (asset) => asset.symbol,
        buildCell: (asset) => Row(
          children: [
            SvgPicture.asset(
              asset.logo,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(asset.symbol,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ColumnDefinition<AssetsBorrowInfo>(
          label: AppLocalizations.of(context)!.avaliable,
          numeric: true,
          getField: (asset) => asset.availableUSD,
          buildCell: (asset) {
            final available = formatDecimal(asset.available, false);
            final availableUSD = formatDecimal(asset.availableUSD, true);
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(available),
                  Text(availableUSD,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }),
      ColumnDefinition<AssetsBorrowInfo>(
          label: AppLocalizations.of(context)!.apyAndVariable,
          numeric: true,
          getField: (asset) => asset.apy,
          buildCell: (asset) => SizedBox(
              child: Text('${asset.apy.shift(2).toStringAsFixed(2)}%'))),
      ColumnDefinition<AssetsBorrowInfo>(
        label: "",
        numeric: true,
        buildCell: (asset) => Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.borrow,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(tabIndexProvider.notifier).changeTab(5);
                ref.read(reserveProvider.notifier).state = asset.assetInfo;
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.details),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildAssetsSuppliesTable(context, ref, items) {
  return SortableTable(
    id: 'assets_supplies_table',
    items: items,
    columns: [
      ColumnDefinition<AssetsSupplyInfo>(
        label: AppLocalizations.of(context)!.asset,
        numeric: false,
        getField: (asset) => asset.symbol,
        buildCell: (asset) => Row(
          children: [
            SvgPicture.asset(
              asset.logo,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(asset.symbol,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ColumnDefinition<AssetsSupplyInfo>(
        label: AppLocalizations.of(context)!.walletBalance,
        numeric: true,
        getField: (asset) => asset.balance,
        buildCell: (asset) =>
            Center(child: Text(formatDecimal(asset.balance, false))),
      ),
      ColumnDefinition<AssetsSupplyInfo>(
        label: AppLocalizations.of(context)!.apy,
        numeric: true,
        getField: (asset) => asset.apy,
        buildCell: (asset) =>
            Center(child: Text('${asset.apy.shift(2).toStringAsFixed(2)}%')),
      ),
      ColumnDefinition<AssetsSupplyInfo>(
        label: AppLocalizations.of(context)!.canBeCollateral,
        numeric: false,
        getField: (asset) => asset.collateral ? 'true' : 'false',
        buildCell: (asset) => Center(
            child: Transform.scale(
                scale: 0.7,
                child: Switch(value: false, onChanged: (value) {}))),
      ),
      ColumnDefinition<AssetsSupplyInfo>(
        label: '',
        numeric: false,
        buildCell: (asset) => Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.supply,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                ref.read(tabIndexProvider.notifier).changeTab(5);
                ref.read(reserveProvider.notifier).state = asset.assetInfo;
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('...'),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildMarketTable(context, ref, items) {
  return SortableTable(
    id: 'market_table',
    items: items,
    columns: [
      ColumnDefinition<MarketInfo>(
        label: AppLocalizations.of(context)!.asset,
        numeric: false,
        getField: (asset) => asset.symbol,
        buildCell: (asset) => Row(
          children: [
            SvgPicture.asset(
              asset.logo,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      asset.name.length > 16
                          ? '${asset.name.substring(0, 16)}...'
                          : asset.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(asset.symbol,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
          ],
        ),
      ),
      ColumnDefinition<MarketInfo>(
          label: AppLocalizations.of(context)!.totalSupplied,
          numeric: true,
          getField: (asset) => asset.totalSuppliedUSD,
          buildCell: (asset) {
            final totalSupplied = formatDecimal(asset.totalSupplied, false);
            final totalSuppliedUSD =
                formatDecimal(asset.totalSuppliedUSD, true);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(totalSupplied),
                Text(totalSuppliedUSD,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ));
          }),
      ColumnDefinition<MarketInfo>(
        label: AppLocalizations.of(context)!.supplyApy,
        numeric: true,
        getField: (asset) => asset.supplyAPY,
        buildCell: (asset) => Center(
            child: Text('${asset.supplyAPY.shift(2).toStringAsFixed(2)}%')),
      ),
      ColumnDefinition<MarketInfo>(
          label: AppLocalizations.of(context)!.totalBorrowed,
          numeric: true,
          getField: (asset) => asset.totalBorrowedUSD,
          buildCell: (asset) {
            final totalBorrowed = formatDecimal(asset.totalBorrowed, false);
            final totalBorrowedUSD =
                formatDecimal(asset.totalBorrowedUSD, true);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(totalBorrowed),
                Text(totalBorrowedUSD,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ));
          }),
      ColumnDefinition<MarketInfo>(
        label: AppLocalizations.of(context)!.borrowApyAndVariable,
        numeric: true,
        getField: (asset) => asset.borrowAPY,
        buildCell: (asset) => Center(
            child: Text('${asset.borrowAPY.shift(2).toStringAsFixed(2)}%')),
      ),
      ColumnDefinition<MarketInfo>(
        label: '',
        numeric: false,
        buildCell: (asset) => OutlinedButton(
          onPressed: () {
            ref.read(tabIndexProvider.notifier).changeTab(5);
            ref.read(reserveProvider.notifier).state = asset.assetInfo;
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.details,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
