class Leaderboard {
  const Leaderboard({
    required this.username,
    required this.score,
  });

  final String username;
  final int score;

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      username: json['username'] as String? ?? '',
      score: json['score'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'score': score,
    };
  }
}