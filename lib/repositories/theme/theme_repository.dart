import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/di.dart';
import 'theme_interface.dart';

final themeRepositoryProvider = Provider<IThemeRepository>((ref) {
  return ThemeRepository(preferences: G<SharedPreferences>());
});

class ThemeRepository implements IThemeRepository {
  ThemeRepository({required SharedPreferences preferences}) : _preferences = preferences;
  final SharedPreferences _preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final isDarkTheme = _preferences.getBool(_isDarkThemeSelectedKey);
    return isDarkTheme ?? false;
  }

  @override
  Future<void> updateDarkThemePreference(bool isDarkTheme) async {
    await _preferences.setBool(_isDarkThemeSelectedKey, isDarkTheme);
  }
}
