part of 'game_provider.dart';

class GameState {
  const GameState({
    this.username = '',
    this.artistName = '',
    this.albumName = '',
    this.gameMode = GameMode.mixed,
    this.difficulty = Difficulty.medium,
    this.foundSongs = const [],
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.selectedAnswer,
    this.hasAnswered = false,
    this.isLoading = false,
    this.error,
  });

  final String username;
  final String artistName;
  final String albumName;
  final GameMode gameMode;
  final Difficulty difficulty;
  final List<Song> foundSongs;
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;
  final String? selectedAnswer;
  final bool hasAnswered;
  final bool isLoading;
  final String? error;

  GameState copyWith({
    String? username,
    String? artistName,
    String? albumName,
    GameMode? gameMode,
    Difficulty? difficulty,
    List<Song>? foundSongs,
    List<Question>? questions,
    int? currentQuestionIndex,
    int? score,
    String? selectedAnswer,
    bool? hasAnswered,
    bool? isLoading,
    String? error,
  }) {
    return GameState(
      username: username ?? this.username,
      artistName: artistName ?? this.artistName,
      albumName: albumName ?? this.albumName,
      gameMode: gameMode ?? this.gameMode,
      difficulty: difficulty ?? this.difficulty,
      foundSongs: foundSongs ?? this.foundSongs,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      hasAnswered: hasAnswered ?? this.hasAnswered,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
