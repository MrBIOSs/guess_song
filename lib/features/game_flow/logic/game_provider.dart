import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'game_state.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(const GameState());

  Future<void> searchSong(String query) async {
    state = state.copyWith(isLoading: true);

    try {

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