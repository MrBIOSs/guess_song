import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:guess_song/features/game_flow/models/leaderboard.dart';
import 'package:guess_song/repositories/local_storage/local_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockTalker extends Mock implements Talker {}

void main() {
  late MockSharedPreferences prefs;
  late MockTalker talker;
  late LocalStorageRepository repository;

  setUp(() {
    prefs = MockSharedPreferences();
    talker = MockTalker();

    repository = LocalStorageRepository(
      preferences: prefs,
      talker: talker,
    );
  });

  group('LocalStorageRepository', () {
    test('loadLeaderboard returns empty list when no data stored', () {
      when(() => prefs.getString(any())).thenReturn(null);

      final result = repository.loadLeaderboard();

      expect(result, isEmpty);
    });

    test('loadLeaderboard returns parsed leaderboard list', () {
      final leaderboard = [
        const Leaderboard(username: 'Name1', score: 100),
        const Leaderboard(username: 'Name2', score: 50),
      ];

      final jsonString = jsonEncode(
        leaderboard.map((e) => e.toJson()).toList(),
      );

      when(() => prefs.getString(any())).thenReturn(jsonString);

      final result = repository.loadLeaderboard();

      expect(result.length, 2);
      expect(result[0].username, 'Name1');
      expect(result[0].score, 100);
      expect(result[1].username, 'Name2');
      expect(result[1].score, 50);
    });

    test('loadLeaderboard returns empty list and logs error on invalid json', () {
      when(() => prefs.getString(any())).thenReturn('invalid_json');

      final result = repository.loadLeaderboard();

      expect(result, isEmpty);

      verify(() => talker.handle(
        any(),
        any(),
        'Failed to load leaderboard',
      )).called(1);
    });

    test('saveLeaderboard stores json in SharedPreferences', () async {
      final leaderboard = [
        const Leaderboard(username: 'Name1', score: 200),
      ];

      when(() => prefs.setString(any(), any()))
          .thenAnswer((_) async => true);

      await repository.saveLeaderboard(leaderboard);

      final expectedJson = jsonEncode([
        {'username': 'Name1', 'score': 200}
      ]);

      verify(() => prefs.setString(
        'leaderboard',
        expectedJson,
      )).called(1);
    });
  });
}