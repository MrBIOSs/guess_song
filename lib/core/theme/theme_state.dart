part of 'theme_provider.dart';

class ThemeState {
  const ThemeState(this.isDark);
  final bool isDark;

  ThemeMode get themeMode {
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }
}