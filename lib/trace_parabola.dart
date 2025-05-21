import 'package:flutter/material.dart';

class TraceParabolaScreen extends StatelessWidget {
  const TraceParabolaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draw D')),
      body: Container(
        color: const Color.fromARGB(255, 197, 197, 184),
        padding: const EdgeInsets.all(20),
        child: CustomPaint(
          size: const Size(250, 250),
          painter: DLetterPainter(),
        ),
      ),
    );
  }
}

class DLetterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.deepPurple
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    // Vertical line
    canvas.drawLine(Offset(0, 0), Offset(0, 250), paint);
    canvas.drawLine(Offset(20, 20), Offset(20, 230), paint);

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(0, 250)
          ..lineTo(20, 240)
          ..lineTo(20, 20)
          ..close();

    // Fill the area between the lines
    final fillPaint =
        Paint()
          ..color = const Color.fromARGB(
            77,
            103,
            58,
            183,
          ) // 77 = 30% alpha, 103,58,183 = deepPurple // Choose your fill color
          ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
    path.close();

    // Arc for the curved part of D
    // The arc's left edge is at the same x as the line, so they connect
    Rect outerUpperArcRect = Rect.fromLTRB(
      -95, // left
      0, // top
      95, // right (width of arc)
      115, // bottom
    );
    // Start at -pi/2 (top), sweep pi (180 deg) for right half
    canvas.drawArc(outerUpperArcRect, -3.1416 / 2, 3.1416 - 0.2, false, paint);

    Rect innerUpperArcRect = Rect.fromLTRB(
      -35, // left
      20, // top
      70, // right (width of arc)
      95, // bottom
    );
    // Start at -pi/2 (top), sweep pi (180 deg) for right half
    canvas.drawArc(innerUpperArcRect, -3.1416 / 2, 3.1416 - 0.09, false, paint);

    final upperArcPath = Path();

    // Outer arc (from left to right)
    upperArcPath.addArc(outerUpperArcRect, -3.1416 / 2, 3.1416 - 0.2);

    // Inner arc (from right to left, reverse direction)
    upperArcPath.arcTo(
      innerUpperArcRect,
      (-3.1416 / 2) + (3.1416 - 0.09),
      -(3.1416 - 0.09),
      false,
    );

    // Close the path to fill the area between arcs
    upperArcPath.close();

    canvas.drawPath(upperArcPath, fillPaint);

    Rect lowerOuterArcRect = Rect.fromLTRB(
      -100, // left
      115, // top
      110, // right (width of arc)
      250, // bottom
    );
    // Start at -pi/2 (top), sweep pi (180 deg) for right half
    canvas.drawArc(lowerOuterArcRect, 1.62, -3.05, false, paint);

    Rect lowerInnerArcRect = Rect.fromLTRB(
      -45, // left
      135, // top
      85, // right (width of arc)
      230, // bottom
    );
    // Start at -pi/2 (top), sweep pi (180 deg) for right half
    canvas.drawArc(lowerInnerArcRect, 1.6, -3.2, false, paint);

    final path1 = Path();

    // Outer arc (from left to right)
    path1.addArc(lowerOuterArcRect, 1.62, -3.05);

    // Inner arc (from right to left, reverse direction)
    path1.arcTo(lowerInnerArcRect, 1.6 + -3.2, 3.2, false);

    // Close the path to fill the area between arcs

    canvas.drawPath(path1, fillPaint);
    path1.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
