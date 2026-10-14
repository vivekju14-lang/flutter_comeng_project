import 'package:flutter/material.dart';

/// Original vector drawing for the welcome screen; no remote image dependency.
class DeveloperArt extends StatelessWidget {
  const DeveloperArt({super.key});
  @override
  Widget build(BuildContext context) => Semantics(
      label: 'Developer with code and connected technology',
      child: CustomPaint(
          size: const Size(300, 250), painter: _DeveloperPainter()));
}

class _DeveloperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 300, size.height / 250);
    final paint = Paint();
    void circle(double x, double y, double r, Color color) {
      paint.color = color;
      canvas.drawCircle(Offset(x, y), r, paint);
    }

    void round(Rect rect, double radius, Color color) {
      paint.color = color;
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius)), paint);
    }

    circle(150, 109, 88, const Color(0xFFF4F0FE));
    round(const Rect.fromLTWH(108, 46, 84, 95), 37, const Color(0xFF29265C));
    circle(150, 81, 24, const Color(0xFFF5BEAE));
    round(const Rect.fromLTWH(124, 90, 52, 64), 20, const Color(0xFFEFA89E));
    round(const Rect.fromLTWH(95, 119, 110, 65), 22, const Color(0xFF8878D8));
    round(const Rect.fromLTWH(111, 133, 78, 53), 5, Colors.white);
    round(const Rect.fromLTWH(76, 176, 148, 10), 3, const Color(0xFFB1A7E9));
    round(const Rect.fromLTWH(54, 197, 192, 42), 7, const Color(0xFFF5D8E3));
    for (var i = 0; i < 3; i++) {
      round(Rect.fromLTWH(71, 207 + i * 9, 95 - i * 15, 3), 1,
          const Color(0xFFD39CB5));
    }
    circle(74, 126, 26, const Color(0xFF8C7ADF));
    circle(229, 132, 26, const Color(0xFF48C5C1));
    circle(214, 79, 19, const Color(0xFF70CDE2));
    circle(89, 67, 14, const Color(0xFFF3A6C5));
    final text = TextPainter(textDirection: TextDirection.ltr);
    void label(String value, double x, double y, Color color, double font) {
      text.text = TextSpan(
          text: value,
          style: TextStyle(
              fontFamily: 'ComengFont',
              color: color,
              fontSize: font,
              fontWeight: FontWeight.bold));
      text.layout();
      text.paint(canvas, Offset(x, y));
    }

    label('</>', 133, 148, const Color(0xFF8878D8), 19);
    label('{ }', 56, 114, Colors.white, 19);
    label('@', 217, 117, Colors.white, 22);
    label('<', 80, 31, const Color(0xFF716AD0), 23);
    label('>', 209, 30, const Color(0xFF716AD0), 23);
    paint
      ..color = const Color(0xFF76CCC7)
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(110, 23), const Offset(104, 36), paint);
    canvas.drawLine(const Offset(188, 21), const Offset(197, 35), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
