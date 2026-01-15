import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static const primaryColor = Colors.teal;
  static const accentColor = Colors.cyan;
  static const errorColor = Color(0xFFCF6679);

  // Light theme
  static const lightBackgroundColor = Colors.white;
  static const lightSecondaryColor = Color(0xFFEFFEFB);
  static const lightSurfaceColor = Colors.white;
  static const lightBorderColor = Color(0xFFCCCCCC);
  static const lightFillColor = Colors.white;
  static const lightTextColor = Color(0xFF282828);
  static const lightDisabledTextColor = Color(0xFF999999);

  // Dark theme
  static const darkBackgroundColor = Color(0xFF0F1B2B);
  static const darkSecondaryColor = Color(0xFF023137);
  static const darkSurfaceColor = Color(0xFF3D3D3D);
  static const darkFillColor = Color(0xFF192533);
  static const darkTextColor = Colors.white;
  static const darkDisabledTextColor = Color(0xFFB3B3B3);

  static const borderRadius = 12.0;

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),

    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  );

  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundColor,
    primaryColor: primaryColor,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: primaryColor,
      secondary: accentColor,
      secondaryContainer: lightSecondaryColor,
      error: errorColor,
      surface: lightSurfaceColor,
      outline: lightBorderColor,
    ),

    fontFamily: GoogleFonts.notoSans().fontFamily,
    textTheme: _textTheme.apply(
      bodyColor: lightTextColor,
      displayColor: lightTextColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurfaceColor,
      foregroundColor: lightTextColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: lightTextColor,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      fillColor: lightFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: lightBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      hintStyle: const TextStyle(fontSize: 14, color: lightDisabledTextColor),
    ),

    outlinedButtonTheme: _outlinedButtonTheme,

    switchTheme: _switchTheme(
      activeThumb: accentColor,
      activeTrack: primaryColor.withValues(alpha: .3),
    ),

    progressIndicatorTheme: _progressIndicatorTheme(color: Colors.grey.shade800),

    listTileTheme: _listTileTheme(color: Colors.grey.shade100),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: primaryColor,

    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark
    ).copyWith(
      primary: primaryColor,
      secondary: accentColor,
      secondaryContainer: darkSecondaryColor,
      error: errorColor,
      surface: darkSurfaceColor,
      outline: Colors.grey.shade800,
    ),

    fontFamily: GoogleFonts.notoSans().fontFamily,
    textTheme: _textTheme.apply(
      bodyColor: darkTextColor,
      displayColor: darkTextColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      foregroundColor: darkTextColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: darkTextColor,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      fillColor: darkFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      hintStyle: TextStyle(fontSize: 14, color: darkDisabledTextColor.withValues(alpha: .7)),
    ),

    outlinedButtonTheme: _outlinedButtonTheme,

    switchTheme: _switchTheme(
      activeThumb: accentColor,
      activeTrack: primaryColor.withValues(alpha: .5),
    ),

    progressIndicatorTheme: _progressIndicatorTheme(color: Colors.grey.shade300),

    listTileTheme: _listTileTheme(color: darkFillColor),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
    ),
  );

  static SwitchThemeData _switchTheme({
    required Color activeThumb,
    required Color activeTrack,
  }) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
            ? activeThumb
            : Colors.grey,
      ),
      trackColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
            ? activeTrack
            : Colors.grey.withValues(alpha: .3),
      ),
    );
  }

  static ProgressIndicatorThemeData _progressIndicatorTheme({
    required Color color,
  }) {
    return ProgressIndicatorThemeData(
      borderRadius: BorderRadius.circular(borderRadius),
      linearMinHeight: 8,
      linearTrackColor: color.withValues(alpha: 0.2),
      color: color,
    );
  }

  static ListTileThemeData _listTileTheme({
    required Color color,
  }) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      tileColor: color,
      minLeadingWidth: 12,
    );
  }
}