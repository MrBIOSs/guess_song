import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../app/di.dart';
import '../../../repositories/local_storage/local_storage.dart';
import '../../../repositories/music_api/models/song.dart';
import '../../../repositories/music_api/music_api.dart';
import '../../../utils/game_utils.dart';
import '../models/models.dart';
import '../view/game_summary/models/leaderboard.dart';

part 'game_state.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(
    musicRepo: ref.read(iTunesRepositoryProvider),
    localStorageRepo: ref.read(localStorageProvider),
    talker: G<Talker>(),
  );
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier({
    required ILocalStorage localStorageRepo,
    required IMusicRepository musicRepo,
    required Talker talker,
  })
      : _localStorageRepo = localStorageRepo, _musicRepo = musicRepo, _talker = talker,
        super(const GameState());

  final ILocalStorage _localStorageRepo;
  final IMusicRepository _musicRepo;
  final Talker _talker;

  void setUsername(String value) => state = state.copyWith(username: value, error: null);

  void setArtistName(String value) {
    state = state.copyWith(artistName: value, foundSongs: [], error: null);
  }

  void setAlbumName(String value) {
    state = state.copyWith(albumName: value, foundSongs: [], error: null);
  }

  void setGameMode(GameMode mode) {
    state = state.copyWith(gameMode: mode, albumName: '', foundSongs: [], error: null);
  }

  void setDifficulty(Difficulty diff) => state = state.copyWith(difficulty: diff, error: null);

  Future<void> searchSongs() async {
    if (state.artistName.trim().isEmpty) {
      state = state.copyWith(error: 'Enter artist name', isLoading: false);
      return;
    }
    if (state.gameMode == GameMode.album && state.albumName.trim().isEmpty) {
      state = state.copyWith(error: 'Enter album name', isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      List<Song> songs;
      if (state.gameMode == GameMode.album) {
        songs = await _musicRepo.getTracksFromAlbum(
          artistName: state.artistName,
          albumName: state.albumName,
        );
      } else {
        songs = await _musicRepo.getTracksByArtist(state.artistName);
      }
      state = state.copyWith(foundSongs: songs, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: 'Search failed', isLoading: false);
    }
  }

  Future<List<Question>> generateQuestions(List<Song> pool) async {
    if (pool.length < 4) {
      state = state.copyWith(error: 'Not enough songs (min 4)');
      return [];
    }

    final uniqueSongs = <Song>[];
    final seenTitles  = <String>{};

    for (final song in pool) {
      if (seenTitles.add(song.title.toLowerCase())) {
        uniqueSongs.add(song);
      }
    }

    if (uniqueSongs.length < 4) {
      state = state.copyWith(error: 'Not enough unique songs');
      return [];
    }

    final shuffled = List<Song>.from(uniqueSongs)..shuffle();
    final selected = shuffled.take(10).toList();
    final questions = <Question>[];

    for (final song in selected) {
      final others = uniqueSongs
          .where((s) => s.title.toLowerCase() != song.title.toLowerCase())
          .toList()..shuffle();

      final decoysCount = others.length < 3 ? others.length : 3;
      final decoys = others.take(decoysCount).map((s) => s.title).toList();
      final options = [song.title, ...decoys]..shuffle();

      questions.add(Question(song: song, options: options));
    }
    return questions;
  }

  Future<void> startGame() async {
    if (state.username.trim().isEmpty || state.artistName.trim().isEmpty) {
      state = state.copyWith(error: 'Fill all fields');
      return;
    }
    final questions = await generateQuestions(state.foundSongs);

    if (questions.isNotEmpty) {
      state = state.copyWith(
        questions: questions,
        currentQuestionIndex: 0,
        score: 0,
        selectedAnswer: null,
        hasAnswered: false,
        error: null,
      );
    }

    _talker.info('[Starting game]\n'
        'Player name: ${state.username}\n'
        'Game Mode: ${state.gameMode.name}\n'
        'Artist: ${state.artistName}\n'
        'Album Name: ${state.artistName}\n'
        'Difficulty: ${state.difficulty.name}\n'
        'Questions: ${state.questions.length}'
    );
  }

  void selectAnswer(String answer) {
    if (state.hasAnswered) return;

    final isCorrect = answer == state.questions[state.currentQuestionIndex].song.title;
    final newScore = isCorrect 
        ? state.score + DifficultySettings.get(state.difficulty).points 
        : state.score;

    state = state.copyWith(
      selectedAnswer: answer,
      hasAnswered: true,
      score: newScore,
    );
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      _talker.info('[Next question #${state.currentQuestionIndex + 1}]\n'
          'Current answer: ${state.selectedAnswer}\n'
          'Correct answer: ${state.questions[state.currentQuestionIndex].song.title}'
      );

      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedAnswer: '',
        hasAnswered: false,
      );
    }
  }

  void finishGame() {
    List<Leaderboard> board = _localStorageRepo.loadLeaderboard();
    state = state.copyWith(leaderboard: board);

    final newList = Leaderboard(
      username: state.username,
      score: state.score,
      rank: getRank(state.score),
    );
    final currentBoard = List<Leaderboard>.from(state.leaderboard);
    final existingIndex = currentBoard.indexWhere((user) => user.username == state.username);

    if (existingIndex == -1) {
      currentBoard.add(newList);
    } else {
      final existingUser = currentBoard[existingIndex];
      if (state.score > existingUser.score) {
        currentBoard[existingIndex] = newList;
      }
    }
    currentBoard.sort((a, b) => b.score.compareTo(a.score));

    board = currentBoard.take(5).toList();
    _saveLeaderboard(board);
    state = state.copyWith(leaderboard: board);

    final user = state.leaderboard.isNotEmpty
        ? state.leaderboard[0].username : 'None';

    _talker.info('[End Game]\n'
        'Total players: ${state.leaderboard.length}\n'
        'Top 1: $user'
    );
  }

  void restart() {
    state = const GameState();
  }

  void _saveLeaderboard(List<Leaderboard> board) {
    _localStorageRepo.saveLeaderboard(board);
    state = state.copyWith(leaderboard: board);
  }
}