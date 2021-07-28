import 'package:flutter/material.dart';

class HeaderCardPainter extends CustomPainter {

  final Color color;
  double controlPointHeight = 65;

  HeaderCardPainter({@required this.color, this.controlPointHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    
    final p1 = new Offset(0, 0);
    final p2 = new Offset(p1.dx, size.height - controlPointHeight);
    final p3 = new Offset(size.width, p2.dy);
    final p4 = new Offset(p3.dx, p1.dy);
    final c1 = new Offset(size.width /2, size.height);

    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..quadraticBezierTo(c1.dx, c1.dy, p3.dx, p3.dy)
      ..lineTo(p4.dx, p4.dy)
      ..close();

    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(covariant HeaderCardPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}