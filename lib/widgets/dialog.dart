import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 440,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Liquidation risk parameters',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your health factor and loan to value determine the assurance of your collateral. To avoid liquidations you can supply more collateral or repay borrow positions.',
                      style: TextStyle(fontSize: 14),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Learn more'),
                    ),
                    // const Divider(),
                    const SizedBox(height: 16),
                    buildRiskCard(
                      context,
                      'Health factor',
                      'Safety of your deposited collateral against the borrowed assets and its underlying value.',
                      7.92,
                      1.00,
                      'If the health factor goes below 1, the liquidation of your collateral might be triggered.',
                      false,
                    ),
                    const SizedBox(height: 16),
                    buildRiskCard(
                      context,
                      'Current LTV',
                      'Your current loan to value based on your collateral supplied.',
                      8.59,
                      68.04,
                      'If your loan to value goes above the liquidation threshold your collateral supplied may be liquidated.',
                      true,
                      additionalInfo: 'MAX 54.59%',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRiskCard(
    BuildContext context,
    String title,
    String description,
    double value,
    double threshold,
    String warning,
    bool isLTV, {
    String? additionalInfo,
  }) {
    final divisor = isLTV ? 100 : 10;
    double position = value / divisor;
    Color? color;
    final firstColor = isLTV ? Colors.green : Colors.red;
    final secondColor = isLTV ? Colors.red : Colors.green;
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]!
        : Colors.grey[300]!;

    if (position <= 0.5) {
      color = Color.lerp(firstColor, Colors.yellow, position * 2);
    } else {
      color = Color.lerp(Colors.yellow, secondColor, (position - 0.5) * 2);
    }
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 54,
                      padding: const EdgeInsets.only(top: 16, left: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: Text(
                        isLTV
                            ? '${value.toStringAsFixed(2)}%'
                            : value.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: additionalInfo == null ? 32 : 48,
                      ),
                      Positioned(
                        left: (value / divisor) * width - 8,
                        child: Column(
                          crossAxisAlignment: value / divisor > 0.5
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              isLTV
                                  ? "${value.toStringAsFixed(2)}%"
                                  : value.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            additionalInfo == null
                                ? const SizedBox()
                                : Text(
                                    additionalInfo,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: additionalInfo == null ? 16 : 32,
                        left: (value / divisor) * width - 12,
                        child:
                            const Icon(Icons.arrow_drop_down_sharp, size: 24),
                      ),
                    ],
                  ),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [firstColor, Colors.yellow, secondColor],
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                  ),
                  Positioned(
                    top: -8,
                    left: (threshold / divisor) * width - 8,
                    child: const Icon(Icons.arrow_drop_up, size: 24),
                  ),
                  Positioned(
                    top: 6,
                    left: (threshold / divisor) * width - 28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          isLTV
                              ? '${threshold.toStringAsFixed(2)}%'
                              : threshold.toStringAsFixed(2),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        const Text(
                          'Liquidation',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        Text(
                          isLTV ? 'threshold' : 'value',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                warning,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }
}
