enum GameMode { mixed, album }
enum Difficulty { easy, medium, hard }

class DifficultySettings {
  const DifficultySettings({required this.clipDuration, required this.points});

  final int clipDuration;
  final int points;
}

extension DifficultExtension on Difficulty {
  DifficultySettings get settings => switch (this) {
    Difficulty.easy => const DifficultySettings(clipDuration: 30, points: 10),
    Difficulty.medium => const DifficultySettings(clipDuration: 15, points: 20),
    Difficulty.hard => const DifficultySettings(clipDuration: 10, points: 30),
  };
}
