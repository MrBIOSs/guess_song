import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/di.dart';
import '../../features/game_flow/view/game_summary/models/leaderboard.dart';
import 'local_storage_interface.dart';

final localStorageProvider = Provider<ILocalStorage>((ref) {
  return LocalStorageRepository(G<SharedPreferences>());
});

class LocalStorageRepository implements ILocalStorage {
  LocalStorageRepository(SharedPreferences prefs) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _kLeaderboardKey = 'leaderboard';

  @override
  List<Leaderboard> loadLeaderboard() {
    final jsonString = _prefs.getString(_kLeaderboardKey);
    if (jsonString == null) return [];

    try {
      final list = jsonDecode(jsonString) as List;
      return list
          .map((e) => Leaderboard.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveLeaderboard(List<Leaderboard> list) async {
    final jsonList = list.map((e) => e.toJson()).toList();
    await _prefs.setString(_kLeaderboardKey, jsonEncode(jsonList));
  }
}