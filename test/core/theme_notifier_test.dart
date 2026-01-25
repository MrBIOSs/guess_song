import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:guess_song/core/theme/theme_provider.dart';
import 'package:guess_song/repositories/theme/theme.dart';

class MockThemeRepository extends Mock implements IThemeRepository {}

void main() {
  late MockThemeRepository repository;
  late ThemeNotifier notifier;

  setUp(() {
    repository = MockThemeRepository();
  });

  group('ThemeNotifier', () {
    test('initial state is loaded from repository', () {
      when(() => repository.isDarkThemeSelected()).thenReturn(true);

      notifier = ThemeNotifier(repository);

      expect(notifier.state.isDark, true);
      expect(notifier.state.themeMode, ThemeMode.dark);
    });

    test('setThemeBrightness(true) updates state and saves preference', () async {
      when(() => repository.isDarkThemeSelected()).thenReturn(false);
      when(() => repository.updateDarkThemePreference(true))
          .thenAnswer((_) async {});

      notifier = ThemeNotifier(repository);

      await notifier.setThemeBrightness(true);

      expect(notifier.state.isDark, true);
      expect(notifier.state.themeMode, ThemeMode.dark);

      verify(() => repository.updateDarkThemePreference(true)).called(1);
    });

    test('setThemeBrightness(false) updates state and saves preference', () async {
      when(() => repository.isDarkThemeSelected()).thenReturn(true);
      when(() => repository.updateDarkThemePreference(false))
          .thenAnswer((_) async {});

      notifier = ThemeNotifier(repository);

      await notifier.setThemeBrightness(false);

      expect(notifier.state.isDark, false);
      expect(notifier.state.themeMode, ThemeMode.light);

      verify(() => repository.updateDarkThemePreference(false)).called(1);
    });
  });
}