import 'package:flutter/material.dart';

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0); // Top vertex
    path.lineTo(0, size.height); // Bottom left vertex
    path.lineTo(size.width, size.height); // Bottom right vertex
    path.close();
    canvas.drawPath(path, Paint()..color = Color(0xff46515f).withOpacity(0.7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
