import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/theme/theme.dart';

part 'theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final repository = ref.watch(themeRepositoryProvider);
  return ThemeNotifier(repository);
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this._repository) : super(const ThemeState(false)) {
    _loadTheme();
  }
  final IThemeRepository _repository;

  void setThemeBrightness(bool isDark) {
    state = ThemeState(isDark);
    _repository.updateDarkThemePreference(isDark);
  }

  Future<void> _loadTheme() async {
    final isDark = _repository.isDarkThemeSelected();
    state = ThemeState(isDark);
  }
}