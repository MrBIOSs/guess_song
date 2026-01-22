import '../../../../../utils/game_utils.dart';

class Leaderboard {
  const Leaderboard({
    required this.username,
    required this.score,
    required this.rank,
  });

  final String username;
  final int score;
  final String rank;

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      username: json['username'] as String? ?? '',
      score: json['score'] as int? ?? 0,
      rank: json['rank'] as String? ?? getRank(0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'score': score,
      'rank': rank,
    };
  }
}