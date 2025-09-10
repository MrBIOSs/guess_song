import 'models/youtube_video.dart';

abstract class IYoutubeRepository {
  Future<List<YoutubeVideo>> searchSong(String query);
}