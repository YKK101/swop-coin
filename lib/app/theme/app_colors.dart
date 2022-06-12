import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

abstract class AppColors {
  static Color primaryColor = Pigment.fromString('#5c5bea');
  static Color secondaryColor = Pigment.fromString('#c4a3fc');
  static Color themeGradient1 = Pigment.fromString('#8477f2');
  static Color themeGradient2 = Pigment.fromString('#c4a3fc');
  static Color dimColor = Colors.black.withOpacity(0.3);
  static Color errorColor = Pigment.fromString('#Fb89a3');
}
