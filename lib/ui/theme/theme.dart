import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFFBB86FC);
  static const _secondaryColor = Color(0xFF03DAC6);
  static const _errorColor = Color(0xFFCF6679);

  static const _darkBackgroundColor = Color(0xFF121212);
  static const _lightBackgroundColor = Color(0xFFF8F9FA);

  static const _darkTextColor = Color(0xFF333333);
  static const _lightTextColor = Colors.white;
  static const _disabledTextColor = Color(0xFFB3B3B3);

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),

    bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14),

    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: _darkBackgroundColor,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark
    ).copyWith(
      primary: _primaryColor,
      secondary: _secondaryColor,
      error: _errorColor,
      surface: Color(0xFF1E1E1E),
      outline: const Color(0xFF555555),
    ),

    textTheme: _textTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: _darkBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _lightTextColor,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        elevation: 3,
        shadowColor: _secondaryColor.withValues(alpha: .3),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
      ),
    ),

    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2D2D2D),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: _disabledTextColor),
      hintStyle: TextStyle(color: _disabledTextColor.withValues(alpha: .7)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return _secondaryColor;
          return Colors.grey;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return _primaryColor.withValues(alpha: .5);
          return Colors.grey.withValues(alpha: .3);
        },
      ),
    ),
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: _lightBackgroundColor,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: _primaryColor,
      secondary: _secondaryColor,
      error: _errorColor,
      surface: Colors.white,
      outline: const Color(0xFFCCCCCC),
    ),

    textTheme: _textTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _darkTextColor,
      ),
      shadowColor: Color(0xFFDDDDDD),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        elevation: 2,
        shadowColor: Colors.grey.withValues(alpha: .2),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
      ),
    ),

    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: Color(0xFF666666)),
      hintStyle: const TextStyle(color: Color(0xFF999999)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return _secondaryColor;
          return Colors.grey;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return _primaryColor.withValues(alpha: .3);
          return Colors.grey.withValues(alpha: .2);
        },
      ),
    ),
  );
}