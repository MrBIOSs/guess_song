part of 'audio_player_provider.dart';

class AudioPlayerState {
  const AudioPlayerState({
    this.isPlaying = false,
    this.progress = 0.0,
    this.errorMessage,
  });

  final bool isPlaying;
  final double progress;
  final String? errorMessage;

  AudioPlayerState copyWith({
    bool? isPlaying,
    double? progress,
    String? errorMessage,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}