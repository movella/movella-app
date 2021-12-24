import 'package:flutter/material.dart';

class ExtendedColors {
  static final chilledChilly = _createMaterialColor(Color(0xFFEB3C33));
}

MaterialColor _createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) strengths.add(0.1 * i);

  strengths.forEach((strength) {
    final ds = 0.5 - strength;

    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : 255 - r) * ds).round(),
      g + ((ds < 0 ? g : 255 - g) * ds).round(),
      b + ((ds < 0 ? b : 255 - b) * ds).round(),
      1,
    );
  });

  return MaterialColor(color.value, swatch);
}
