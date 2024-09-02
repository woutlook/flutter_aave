import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tlend_app/config/network.dart';
import 'package:tlend_app/providers/network.dart';
import 'package:tlend_app/widgets/dialog.dart';

Widget buildNetworkMenu(context, ref, List<NetworkConfig> networks) {
  return MenuAnchor(
    builder: (context, controller, child) {
      return IconButton(
        iconSize: 32,
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        isSelected: controller.isOpen,
        icon: const Icon(Icons.expand_more_outlined),
        selectedIcon: const Icon(Icons.expand_less_outlined),
      );
    },
    menuChildren: networks
        .map((network) => MenuItemButton(
              leadingIcon: SvgPicture.asset(
                'assets/icons/networks/${(network.mainId != null ? allNetworks[network.mainId] : network)?.chainName.toLowerCase()}.svg',
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              child:
                  Text(network.chainName, style: const TextStyle(fontSize: 20)),
              onPressed: () {
                ref
                    .read(networkProvider.notifier)
                    .changeNetwork(network.chainId);
              },
            ))
        .toList(),
  );
}

Widget buildNetworks(context, ref, networks) {
  final network = networks[0];
  return SizedBox(
    width: 500,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/networks/${(network.mainId != null ? allNetworks[network.mainId] : network)?.chainName.toLowerCase()}.svg',
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  network.chainName,
                  style: const TextStyle(fontSize: 30),
                ),
                buildNetworkMenu(context, ref, networks),
              ],
            ),
            buildNetworkInfo(context),
          ],
        ),
      ),
    ),
  );
}

Widget buildNetworkInfo(context) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Net worth',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$74.99K',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Net APY',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              Text(
                '10.66%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Health factor',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  const Flexible(
                    child: Text(
                      '7.92',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Transform.scale(
                      scale: 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          textStyle: const TextStyle(fontSize: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)), // 设置圆角大小
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomDialog();
                            },
                          );
                        },
                        child: const Text('RISK DETAILS'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
