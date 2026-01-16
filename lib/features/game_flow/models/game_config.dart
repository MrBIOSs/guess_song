enum GameMode { mixed, album }
enum Difficulty { easy, medium, hard }

class DifficultySettings {
  const DifficultySettings({required this.clipDuration, required this.points});

  final int clipDuration;
  final int points;

  static DifficultySettings get(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy: return const DifficultySettings(clipDuration: 30, points: 10);
      case Difficulty.medium: return const DifficultySettings(clipDuration: 15, points: 20);
      case Difficulty.hard: return const DifficultySettings(clipDuration: 10, points: 30);
    }
  }
}