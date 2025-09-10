part of 'game_provider.dart';

class GameState {
  const GameState({
    this.videos,
    this.isLoading = false,
    this.error,
  });

  final List<YoutubeVideo>? videos;
  final bool isLoading;
  final String? error;

  String get artistTitle => videos?[0].artist ?? '???';

  GameState copyWith({
    List<YoutubeVideo>? videos,
    bool? isLoading,
    String? error,
  }) {
    return GameState(
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
