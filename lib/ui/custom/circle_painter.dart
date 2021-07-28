import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {

  final Color color;

  CirclePainter({@required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 3;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double s = size.width / 2;
    final double radius = s - strokeWidth;

    canvas.drawCircle(Offset(s, s), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}