import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tlend_app/providers/platform/platform.dart';
import 'package:tlend_app/providers/utils.dart';
import 'package:tlend_app/widgets/tab.dart';

class MyAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final List<Widget> tabs;

  const MyAppBar({
    super.key,
    required this.actions,
    required this.tabs,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _MyAppBarState extends ConsumerState<MyAppBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    ref.read(walletStateProvider.notifier).connect();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabBar(context, tabs) {
    final tabIndex = ref.watch(tabIndexProvider);
    _tabController.index =
        tabIndex.index > tabs.length - 1 ? tabIndex.prev : tabIndex.index;
    final tabBar = TabBar(
      controller: _tabController,
      labelStyle: const TextStyle(fontSize: 20),
      isScrollable: true,
      indicator: GradientUnderlineTabIndicator(
        gradient: const LinearGradient(
            colors: [Colors.red, Colors.yellow, Colors.green]),
        width: 3,
      ),
      labelPadding: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.only(right: 0.0),
      tabs: tabs,
      indicatorWeight: 1,
      tabAlignment: TabAlignment.start,
    );
    return tabBar;
  }

  Widget buildSettingMenu(context) {
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
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
        );
      },
      menuChildren: [
        // MenuItemButton(
        //   onPressed: () {},
        // ),
        MenuItemButton(
          child: const Text('Settings'),
          onPressed: () {},
        ),
        MenuItemButton(
          child: const Text('Logout'),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = _buildTabBar(context, widget.tabs);
    final actions = widget.actions;
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
              child: SvgPicture.asset('assets/icons/SVG/thr.svg',
                  width: 120, height: 50)),
          tabBar,
          Expanded(child: Container()),
          ...actions,
        ],
      ),
    );
  }
}

class BrightnessButton extends ConsumerWidget {
  const BrightnessButton({
    super.key,
    required this.tooltipMessage,
    this.showTooltipBelow = true,
  });

  final bool showTooltipBelow;
  final String tooltipMessage;

  @override
  Widget build(context, ref) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: tooltipMessage,
      child: IconButton(
        iconSize: 24,
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => ref.read(brightnessProvider.notifier).state =
            isBright ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
