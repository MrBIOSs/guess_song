part of 'game_provider.dart';

class GameState {
  const GameState({
    this.isLoading = false,
    this.error,
  });

  final bool isLoading;
  final String? error;


  GameState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return GameState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
