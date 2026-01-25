import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../features/game_flow/models/leaderboard.dart';
import 'local_storage_interface.dart';

class LocalStorageRepository implements ILocalStorage {
  LocalStorageRepository({
    required SharedPreferences preferences,
    required Talker talker
  }) : _prefs = preferences, _talker = talker;

  final SharedPreferences _prefs;
  final Talker _talker;

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
    } catch (e, st) {
      _talker.handle(e, st, 'Failed to load leaderboard');
      return [];
    }
  }

  @override
  Future<void> saveLeaderboard(List<Leaderboard> list) async {
    final jsonList = list.map((e) => e.toJson()).toList();
    await _prefs.setString(_kLeaderboardKey, jsonEncode(jsonList));
  }
}