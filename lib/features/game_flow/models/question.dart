import '../../../repositories/music_api/models/song.dart';

class Question {
  Question({required this.song, required this.options});

  final Song song;
  final List<String> options;
}