import 'package:flutter/material.dart';

class DashedLineHorizontalPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Paint painter;

  DashedLineHorizontalPainter({
    required this.dashWidth,
    required this.dashSpace,
    required Color color,
  }) : painter = Paint()
    ..color = color
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        painter,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class DashedHorizontalDivider extends StatelessWidget {
  final double width;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedHorizontalDivider({
    Key? key,
    this.width = double.infinity,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 1.0,
      child: CustomPaint(
        painter: DashedLineHorizontalPainter(
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          color: color,
        ),
      ),
    );
  }
}
