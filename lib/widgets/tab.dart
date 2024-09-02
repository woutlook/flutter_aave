import 'package:flutter/material.dart';

class GradientUnderlineTabIndicator extends Decoration {
  final BoxPainter _painter;

  GradientUnderlineTabIndicator(
      {required Gradient gradient, required double width})
      : _painter = _GradientPainter(gradient: gradient, width: width);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _GradientPainter extends BoxPainter {
  final Gradient gradient;
  final double width;

  _GradientPainter({required this.gradient, required this.width});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(
          offset.dx,
          configuration.size!.height - width,
          configuration.size!.width,
          width));
    final Rect rect = Offset(offset.dx, configuration.size!.height - width) &
        Size(configuration.size!.width, width);
    canvas.drawRect(rect, paint);
  }
}
