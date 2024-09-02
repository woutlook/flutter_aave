import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tlend_app/providers/utils.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({super.key});

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  @override
  Widget build(BuildContext context) {
    const body = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReserveHeader(),
          SizedBox(height: 20),
          ReserveStatusConfiguration(),
        ],
      ),
    );
    return body;
  }
}

class ReserveHeader extends ConsumerWidget {
  const ReserveHeader({super.key});

  @override
  Widget build(context, ref) {
    final asset = ref.watch(reserveProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    ref.read(tabIndexProvider.notifier).goback();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 4), // 添加一些间距
                      Text('Go back',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  asset.logo,
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 10),
                Text(asset.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Reserve Size: \$21.96M',
                style: TextStyle(fontSize: 18)),
            const Text('Available liquidity: \$5.14M',
                style: TextStyle(fontSize: 18)),
            const Text('Utilization Rate: 76.62%',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Oracle price: \$1.00', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class ReserveStatusConfiguration extends StatelessWidget {
  const ReserveStatusConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reserve status & configuration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Supply Info', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const CircularProgressIndicator(
                    value: 0.011, strokeWidth: 5), // Total supplied progress
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total supplied: 21.96M of 2.00B',
                        style: TextStyle(fontSize: 16)),
                    Text('APY: 2.68%', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Collateral usage', style: TextStyle(fontSize: 18)),
            const Text('Can be collateral',
                style: TextStyle(fontSize: 16, color: Colors.green)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Max LTV', style: TextStyle(fontSize: 16)),
                    Text('80.00%', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Text('Liquidation threshold',
                        style: TextStyle(fontSize: 16)),
                    Text('85.00%', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Text('Liquidation penalty', style: TextStyle(fontSize: 16)),
                    Text('5.00%', style: TextStyle(fontSize: 16)),
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
