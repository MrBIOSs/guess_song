import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/di.dart';
import '../../repositories/theme/theme.dart';

part 'theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(G<IThemeRepository>());
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this._repository)
      : super(ThemeState(_repository.isDarkThemeSelected()));
  final IThemeRepository _repository;

  Future<void> setThemeBrightness(bool isDark) async {
    state = ThemeState(isDark);
    await _repository.updateDarkThemePreference(isDark);
  }
}