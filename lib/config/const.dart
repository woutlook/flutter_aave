// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// NavigationRail shows if the screen width is greater or equal to
// narrowScreenWidthThreshold; otherwise, NavigationBar is used for navigation.
const double narrowScreenWidthThreshold = 450;

// const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1540;

const double transitionLength = 500;

// Whether the user has chosen a theme color via a direct [ColorSeed] selection,
// or an image [ColorImageProvider].
enum ColorSelectionMethod {
  colorSeed,
  image,
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ColorImageProvider {
  leaves('Leaves',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
  peonies('Peonies',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_2.png'),
  bubbles('Bubbles',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png'),
  seaweed('Seaweed',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png'),
  seagrapes('Sea Grapes',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png'),
  petals('Petals',
      'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png');

  const ColorImageProvider(this.label, this.url);
  final String label;
  final String url;
}

enum ScreenSelected {
  dashborad(0),
  markets(1),
  reverse(2),
  stake(3),
  governance(4);

  const ScreenSelected(this.value);
  final int value;
}

const rowDivider = SizedBox(width: 20);
const colDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;

const walletConneteProjectId = '3889eca29bf4f3e51cbfa928b2dd5f66';

enum ChainId {
  ethereum(1),
  arbitrum(42161),
  optimism(10),
  basechain(1337),
  bsc(56),
  polygon(137),
  avalanche(43114),
  fantom(250),
  ethereumSepolia(11155111),
  arbitrumSepolia(421614),
  optimismSepolia(100),
  basechainSepolia(13371),
  bscTest(97),
  mumbai(80001),
  fuji(43113),
  fantomTest(4002),
  error(0);

  const ChainId(this.id);
  final int id;

  static ChainId fromId(int id) {
    return ChainId.values.firstWhere((e) => e.id == id, orElse: () => error);
  }
}
