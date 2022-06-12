import 'package:flutter/material.dart';
import 'package:swop_coin/app/theme/app_colors.dart';

class BackgroundPainter extends CustomPainter {
  final double curveFooterHeight;

  const BackgroundPainter({
    Key? key,
    this.curveFooterHeight = 100.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.themeGradient1, AppColors.themeGradient2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.3, 0.7],
      ).createShader(Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - curveFooterHeight);
    path.quadraticBezierTo(
      size.width,
      size.height - curveFooterHeight * 0.3,
      size.width * 0.8,
      size.height - curveFooterHeight * 0.4,
    );
    path.lineTo(size.width * 0.8, size.height - curveFooterHeight * 0.4);
    path.quadraticBezierTo(
      size.width * 0.65,
      size.height - curveFooterHeight * 0.55,
      size.width * 0.6,
      size.height - curveFooterHeight * 0.5,
    );
    path.lineTo(size.width * 0.6, size.height - curveFooterHeight * 0.5);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - curveFooterHeight * 0.5,
      size.width * 0.4,
      size.height - curveFooterHeight * 0.2,
    );
    path.lineTo(size.width * 0.4, size.height - curveFooterHeight * 0.2);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.2,
      size.height,
    );
    path.lineTo(size.width * 0.2, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - curveFooterHeight * 0.9,
    );
    path.lineTo(0, size.height - curveFooterHeight * 0.9);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
