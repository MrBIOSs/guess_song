enum PlayerRank { newbie, fan, expert, legend }

PlayerRank getPlayerRank(int score) {
  if (score < 50) return PlayerRank.newbie;
  if (score <= 100) return PlayerRank.fan;
  if (score <= 200) return PlayerRank.expert;
  return PlayerRank.legend;
}

extension PlayerRankExtension on PlayerRank {
  String get label => switch (this) {
    PlayerRank.newbie => 'Newbie',
    PlayerRank.fan => 'Fan',
    PlayerRank.expert => 'Expert',
    PlayerRank.legend => 'Legend',
  };
}