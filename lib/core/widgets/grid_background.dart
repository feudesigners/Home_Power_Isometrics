import 'package:flutter/material.dart';

import '../../app/theme/isometrix_theme.dart';

class GridBackground extends StatelessWidget {
  const GridBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: dark ? IsometrixColors.bgDark : IsometrixColors.bgLight,
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.8),
          radius: 1.2,
          colors: [
            IsometrixColors.indigo.withValues(alpha: dark ? 0.12 : 0.07),
            Colors.transparent,
          ],
        ),
      ),
      child: CustomPaint(
        painter: _GridPainter(
          color: (dark ? Colors.white : Colors.black).withValues(
            alpha: dark ? 0.015 : 0.05,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
