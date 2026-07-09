import 'package:flutter/material.dart';

class DesignSystem {
  static const background = Color(0xFF0B0618);
  static const card = Color(0xFF1A102E);
  static const primary = Color(0xFF8B5CF6);
  static const secondary = Color(0xFFA855F7);
  static const accent = Color(0xFFC084FC);
  static const white = Colors.white;
  static const grey = Color(0xFFB0B0B0);
  static const success = Color(0xFF22C55E);
  static const danger = Color(0xFFEF4444);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light),
    scaffoldBackgroundColor: const Color(0xFFF6F1FF),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xFFF6F1FF),
      foregroundColor: Color(0xFF0B0618),
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFF0B0618)),
      bodySmall: TextStyle(color: Color(0xFF6B4C8A)),
    ),
    iconTheme: const IconThemeData(color: primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: background,
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardThemeData(
      color: card,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Color(0xFFB9A5D6)),
    ),
    iconTheme: const IconThemeData(color: accent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ),
  );
}