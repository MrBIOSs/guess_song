import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/di.dart';
import 'local_storage_interface.dart';

final localStorageProvider = Provider<ILocalStorage>((ref) {
  return LocalStorageRepository(G<SharedPreferences>());
});

class LocalStorageRepository implements ILocalStorage {
  LocalStorageRepository(SharedPreferences prefs) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _kUsernameKey = 'username';

  @override
  String? getUsername() {
    return _prefs.getString(_kUsernameKey);
  }

  @override
  Future<void> saveUsername(String username) async {
    await _prefs.setString(_kUsernameKey, username);
  }
}