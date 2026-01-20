import '../../features/game_flow/models/game_config.dart';

abstract interface class IAudioPlayer {
  Future<void> loadClip(String audioUrl, Difficulty difficulty);
  Future<void> play();
  Future<void> stop();
  Stream<Duration> get positionStream;
  Stream<bool> get isPlayingStream;
  Stream<double> get progressStream;
  void dispose();
}