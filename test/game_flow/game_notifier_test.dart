import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:guess_song/repositories/local_storage/local_storage.dart';
import 'package:guess_song/repositories/music_api/music_api.dart';
import 'package:guess_song/repositories/music_api/models/song.dart';
import 'package:guess_song/features/game_flow/logic/game_provider.dart';
import 'package:guess_song/features/game_flow/models/models.dart';

class MockMusicRepository extends Mock implements IMusicRepository {}
class MockLocalStorage extends Mock implements ILocalStorage {}
class MockTalker extends Mock implements Talker {}

Song song(String title) => Song(
  id: title.hashCode,
  title: title,
  artistName: 'Artist',
  albumName: 'Album',
  coverUrl: '',
  audioUrl: 'url',
);

void main() {
  late MockMusicRepository musicRepo;
  late MockLocalStorage localStorage;
  late MockTalker talker;
  late GameNotifier notifier;

  setUp(() {
    musicRepo = MockMusicRepository();
    localStorage = MockLocalStorage();
    talker = MockTalker();

    when(() => talker.info(any())).thenReturn(null);
    when(() => talker.handle(any(), any(), any())).thenReturn(null);
    when(() => localStorage.loadLeaderboard()).thenReturn([]);
    when(() => localStorage.saveLeaderboard(any())).thenAnswer((_) async {});

    notifier = GameNotifier(
      musicRepo: musicRepo,
      localStorageRepo: localStorage,
      talker: talker,
    );
  });

  group('Validation', () {
    test('startGame sets error if fields are empty', () async {
      await notifier.startGame();

      expect(notifier.state.error, 'Fill all fields');
    });
  });

  group('searchSongs', () {
    test('sets error if artist name is empty', () async {
      await notifier.searchSongs();

      expect(notifier.state.error, 'Enter artist name');
    });

    test('calls getTracksByArtist in mixed mode', () async {
      notifier.setArtistName('Muse');

      when(() => musicRepo.getTracksByArtist('Muse'))
          .thenAnswer((_) async => [song('song1'), song('song2'), song('song3'), song('song4')]);

      await notifier.searchSongs();

      verify(() => musicRepo.getTracksByArtist('Muse')).called(1);
      expect(notifier.state.foundSongs.length, 4);
    });
  });

  group('startGame', () {
    test('creates questions if enough songs', () async {
      notifier
        ..setUsername('User')
        ..setArtistName('Artist');

      notifier.state = notifier.state.copyWith(
        foundSongs: [
          song('song1'),
          song('song2'),
          song('song3'),
          song('song4'),
        ],
      );

      await notifier.startGame();

      expect(notifier.state.questions.isNotEmpty, true);
      expect(notifier.state.currentQuestionIndex, 0);
      expect(notifier.state.score, 0);
    });

    test('sets error if not enough songs', () async {
      notifier
        ..setUsername('User')
        ..setArtistName('Artist');

      notifier.state = notifier.state.copyWith(
        foundSongs: [song('song1'), song('song2')],
      );

      await notifier.startGame();

      expect(notifier.state.error, 'Not enough songs (min 4)');
    });
  });

  group('game flow', () {
    setUp(() async {
      notifier
        ..setUsername('User')
        ..setArtistName('Artist');

      notifier.state = notifier.state.copyWith(
        foundSongs: [
          song('song1'),
          song('song2'),
          song('song3'),
          song('song14'),
        ],
      );

      await notifier.startGame();
    });

    test('correct answer increases score', () {
      final correct = notifier.state.questions.first.song.title;

      notifier.selectAnswer(correct);

      expect(notifier.state.score, notifier.state.difficulty.settings.points);
      expect(notifier.state.hasAnswered, true);
    });

    test('nextQuestion increments index', () {
      notifier.nextQuestion();

      expect(notifier.state.currentQuestionIndex, 1);
      expect(notifier.state.hasAnswered, false);
    });

    test('finishes game on last question and saves leaderboard', () {
      notifier.state = notifier.state.copyWith(
        currentQuestionIndex: notifier.state.questions.length - 1,
      );

      notifier.nextQuestion();

      verify(() => localStorage.saveLeaderboard(any())).called(1);
      expect(notifier.state.leaderboard.isNotEmpty, true);
    });
  });
}