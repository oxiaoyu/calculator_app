import 'package:flutter/material.dart';

/// Candy color theme for calculator app
class CandyColors {
  CandyColors._();

  // Display area
  static const Color displayBg = Color(0xFFFFFFFF);
  static const Color displayText = Color(0xFF212121);

  // Main background
  static const Color mainBg = Color(0xFFF0F0F0);

  // Number buttons (0-9)
  static const Color numberButtonBg = Color(0xFFFFFFFF);
  static const Color numberButtonText = Color(0xFF212121);

  // Operator buttons (+, -, ×, ÷)
  static const Color operatorButtonBg = Color(0xFFFF9500);
  static const Color operatorButtonText = Color(0xFFFFFFFF);

  // Function buttons (AC, +/-, %)
  static const Color functionButtonBg = Color(0xFFD4D4D4);
  static const Color functionButtonText = Color(0xFF212121);

  // Equals button (=)
  static const Color equalsButtonBg = Color(0xFF34C759);
  static const Color equalsButtonText = Color(0xFFFFFFFF);

  // Button pressed effect (10% darker)
  static Color numberButtonPressed = _darken(numberButtonBg, 0.1);
  static Color operatorButtonPressed = _darken(operatorButtonBg, 0.1);
  static Color functionButtonPressed = _darken(functionButtonBg, 0.1);
  static Color equalsButtonPressed = _darken(equalsButtonBg, 0.1);

  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}

/// Button types for calculator
enum ButtonType {
  number,
  operator,
  function,
  equals,
}

/// App theme configuration
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CandyColors.mainBg,
      colorScheme: const ColorScheme.light(
        surface: CandyColors.mainBg,
        primary: CandyColors.operatorButtonBg,
        secondary: CandyColors.equalsButtonBg,
      ),
    );
  }
}
