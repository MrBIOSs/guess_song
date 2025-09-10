import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/youtube/models/youtube_video.dart';
import '../../../repositories/youtube/youtube.dart';

part 'game_state.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final youtubeRepository = ref.watch(youtubeRepositoryProvider);
  return GameNotifier(youtubeRepo: youtubeRepository);
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier({required this.youtubeRepo}) : super(GameState());
  final IYoutubeRepository youtubeRepo;

  Future<void> searchSong(String query) async {
    state = state.copyWith(isLoading: true);

    try {
      final videos = await youtubeRepo.searchSong(query);
      state = state.copyWith(isLoading: false, videos: videos);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}