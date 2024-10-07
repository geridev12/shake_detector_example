import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomCirclePainter extends CustomPainter {
  const CustomCirclePainter({
    required this.progress,
    required this.isCompleted,
  });

  final double progress;
  final bool isCompleted;

  @override
  void paint(Canvas canvas, Size size) {
    const circleRadius = 150.0;

    final backgroundRingPaintColor =
        isCompleted ? Colors.white : Colors.transparent;

    final backgroundRingPaint = Paint()
      ..color = backgroundRingPaintColor
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final center = Offset(centerX, centerY);

    canvas.drawCircle(
      center,
      circleRadius,
      backgroundRingPaint,
    );

    final progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: circleRadius,
      ),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomCirclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
