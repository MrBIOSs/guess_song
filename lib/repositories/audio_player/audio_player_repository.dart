import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../app/di.dart';
import '../../features/game_flow/models/game_config.dart';
import 'audio_player_interface.dart';

final audioPlayerRepositoryProvider = Provider<IAudioPlayer>((ref) {
  final repo = AudioPlayerRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

class AudioPlayerRepository implements IAudioPlayer {
  AudioPlayerRepository() {
    _progressController = StreamController<double>.broadcast();
    _playingController = StreamController<bool>.broadcast();

    _positionSub = _player.positionStream.listen((position) {
      if (_progressController.isClosed) return;
      if (_clipDuration.inSeconds > 0 && _isPlaying) {
        final elapsedSinceStart = position - _startPosition;
        final progress = elapsedSinceStart.inMilliseconds / _clipDuration.inMilliseconds;

        _progressController.add(progress.clamp(0.0, 1.0));

        if (elapsedSinceStart >= _clipDuration) {
          _stopInternal();
        }
      }
    });

    _player.playerStateStream.listen((state) {
      if (_playingController.isClosed) return;
      _isPlaying = state.playing;
      _playingController.add(_isPlaying);
    });
  }

  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<Duration> _positionSub;
  late final StreamController<double> _progressController;
  late final StreamController<bool> _playingController;

  Duration _startPosition = Duration.zero;
  Duration _clipDuration = Duration.zero;
  String? _audioUrl;
  bool _isPlaying = false;

  @override
  Stream<Duration> get positionStream => _player.positionStream;

  @override
  Stream<bool> get isPlayingStream => _playingController.stream;

  @override
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<void> loadClip(String audioUrl, Difficulty difficulty) async {
    if (audioUrl.isEmpty) {
      G<Talker>().warning('AudioUrl isEmpty!');
      return;
    }

    try {
      await _player.stop();

      _audioUrl = null;
      _clipDuration = Duration.zero;
      _startPosition = Duration.zero;
      _progressController.add(0.0);

      final totalDuration = await _player.setUrl(audioUrl) ?? Duration.zero;
      final settings = DifficultySettings.get(difficulty);

      _clipDuration = Duration(seconds: settings.clipDuration);
      _audioUrl = audioUrl;

      final maxStart = totalDuration.inSeconds - _clipDuration.inSeconds;
      final startTime = maxStart > 0 ? Random().nextInt(maxStart) : 0;
      _startPosition = Duration(seconds: startTime);

      await _player.seek(_startPosition);
    } catch (e) {
      _audioUrl = null;
      rethrow;
    }
  }

  @override
  Future<void> play() async {
    if (_audioUrl == null) return;

    await _player.seek(_startPosition);
    await _player.play();
  }

  @override
  Future<void> stop() async => _stopInternal();

  Future<void> _stopInternal() async {
    await _player.pause();
    await _player.seek(_startPosition);
    _progressController.add(0.0);
    _playingController.add(false);
  }

  @override
  void dispose() {
    _positionSub.cancel();
    _progressController.close();
    _playingController.close();
    _player.dispose();
  }
}