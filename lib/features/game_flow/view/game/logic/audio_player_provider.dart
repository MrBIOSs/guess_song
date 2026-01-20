import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../../app/di.dart';
import '../../../../../repositories/audio_player/audio_player.dart';
import '../../../models/game_config.dart';

part 'audio_player_state.dart';

final audioPlayerProvider = StateNotifierProvider<AudioPlayerNotifier, AudioPlayerState>((ref) {
  final repo = ref.read(audioPlayerRepositoryProvider);
  final notifier = AudioPlayerNotifier(repo);

  ref.onDispose(notifier.dispose);
  return notifier;
});

class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  AudioPlayerNotifier(IAudioPlayer audioPlayer)
      : _audioPlayer = audioPlayer,
        super(const AudioPlayerState()) {
    _setupStreams();
  }

  final IAudioPlayer _audioPlayer;
  StreamSubscription? _progressSub;
  StreamSubscription? _playingSub;

  void _setupStreams() {
    _progressSub = _audioPlayer.progressStream.listen((progress) {
      state = state.copyWith(progress: progress);
    });
    _playingSub = _audioPlayer.isPlayingStream.listen((isPlaying) {
      state = state.copyWith(isPlaying: isPlaying);
    });
  }

  Future<void> loadAudio({
    required String audioUrl,
    required Difficulty difficulty,
  }) async {
    await _audioPlayer.stop();

    state = state.copyWith(errorMessage: null, progress: 0.0, isPlaying: false);
    try {
      await _audioPlayer.loadClip(audioUrl, difficulty);
    } catch (e, st) {
      G<Talker>().handle(e, st, 'Failed to load audio');
      state = state.copyWith(errorMessage: 'Failed to load audio');
    }
  }

  Future<void> play() async {
    try {
      await _audioPlayer.play();
    } catch (e, st) {
      Talker().handle(e, st, 'Audio Play Failed');
      state = state.copyWith(errorMessage: 'Audio Play Failed');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();

      state = state.copyWith(isPlaying: false, progress: 0.0);
    } catch (e, st) {
      G<Talker>().handle(e, st, 'Audio Stop Failed');
    }
  }

  @override
  void dispose() {
    _progressSub?.cancel();
    _playingSub?.cancel();
    super.dispose();
  }
}