import 'package:flutter_test/flutter_test.dart';
import 'package:guess_song/features/game_flow/models/leaderboard.dart';
import 'package:guess_song/utils/game_utils.dart';

void main() {
  group('Leaderboard', () {
    test('creates Leaderboard with correct fields', () {
      const leaderboard = Leaderboard(
        username: 'Name',
        score: 120,
      );

      expect(leaderboard.username, 'Name');
      expect(leaderboard.score, 120);
    });

    test('calculates rank based on score', () {
      const newbie = Leaderboard(username: 'name1', score: 10);
      const fan = Leaderboard(username: 'name2', score: 80);
      const expert = Leaderboard(username: 'name3', score: 150);
      const legend = Leaderboard(username: 'name4', score: 300);

      expect(getPlayerRank(newbie.score), PlayerRank.newbie);
      expect(getPlayerRank(fan.score), PlayerRank.fan);
      expect(getPlayerRank(expert.score), PlayerRank.expert);
      expect(getPlayerRank(legend.score), PlayerRank.legend);
    });

    test('serializes to json correctly', () {
      const leaderboard = Leaderboard(
        username: 'Name',
        score: 200,
      );
      final json = leaderboard.toJson();

      expect(json, {
        'username': 'Name',
        'score': 200,
      });
    });

    test('deserializes from json correctly', () {
      final json = {
        'username': 'Name',
        'score': 90,
      };

      final leaderboard = Leaderboard.fromJson(json);

      expect(leaderboard.username, 'Name');
      expect(leaderboard.score, 90);
    });

    test('fromJson uses default values when fields are missing', () {
      final leaderboard = Leaderboard.fromJson({});

      expect(leaderboard.username, '');
      expect(leaderboard.score, 0);
      expect(getPlayerRank(leaderboard.score), PlayerRank.newbie);
    });
  });
}
