abstract interface class IThemeRepository {
  bool isDarkThemeSelected();
  Future<void> updateDarkThemePreference(bool selected);
}
