import 'dart:async';
import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../features/game_flow/models/game_config.dart';
import 'audio_player_interface.dart';

class AudioPlayerRepository implements IAudioPlayer {
  AudioPlayerRepository(this._talker) {
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

  final Talker _talker;
  final AudioPlayer _player = AudioPlayer();
  late final StreamSubscription<Duration> _positionSub;
  late final StreamController<double> _progressController;
  late final StreamController<bool> _playingController;

  Duration _startPosition = Duration.zero;
  Duration _clipDuration = Duration.zero;
  String? _audioUrl;
  bool _isPlaying = false;

  @override
  Stream<bool> get isPlayingStream => _playingController.stream;

  @override
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<void> loadClip(String audioUrl, Difficulty difficulty) async {
    if (audioUrl.isEmpty) {
      _talker.warning('AudioUrl isEmpty!');
      return;
    }

    try {
      await _player.stop();

      _audioUrl = null;
      _clipDuration = Duration.zero;
      _startPosition = Duration.zero;
      _progressController.add(0.0);

      final totalDuration = await _player.setUrl(audioUrl) ?? Duration.zero;
      final settings = difficulty.settings;

      _clipDuration = Duration(seconds: settings.clipDuration);
      _audioUrl = audioUrl;

      final maxStart = totalDuration.inSeconds - _clipDuration.inSeconds;
      final startTime = maxStart > 0 ? Random().nextInt(maxStart) : 0;
      _startPosition = Duration(seconds: startTime);

      await _player.seek(_startPosition);
    } catch (e, st) {
      _audioUrl = null;
      _talker.error('Failed to load audio', e, st);
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
  }

  @override
  Future<void> dispose() async {
    await _positionSub.cancel();
    _progressController.close();
    _playingController.close();
    _player.dispose();
  }
}