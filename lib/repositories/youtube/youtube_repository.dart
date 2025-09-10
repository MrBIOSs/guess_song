import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/dio_client.dart';
import '../../app/di.dart';
import 'models/youtube_video.dart';
import 'youtube_repository_interface.dart';

final youtubeRepositoryProvider = Provider<IYoutubeRepository>((ref) {
  return YoutubeRepository(dioClient: G<YoutubeDioClient>());
});

class YoutubeRepository implements IYoutubeRepository {
  YoutubeRepository({required this.dioClient});
  final YoutubeDioClient dioClient;

  @override
  Future<List<YoutubeVideo>> searchSong(String query) async {
    final response = await dioClient.get('/search', query: {
      'q': query,
      'part': 'snippet',
      'type': 'video',
      'maxResults': '10',
      'videoCategoryId': '10',
    });

    final List<dynamic> items = response.data['items'];
    final List<YoutubeVideo> videos = [];

    for (var item in items) {
      final snippet = item['snippet'];
      final videoId = item['id']['videoId'];

      final cleanTitle = _extractTitle(snippet['title']);
      final artist = _extractArtist(snippet['title']) ?? 'Unknown Artist';

      videos.add(
        YoutubeVideo(
          id: videoId,
          title: cleanTitle,
          artist: artist,
          thumbnailUrl: snippet['thumbnails']['high']['url'],
        ),
      );
    }
    return videos;
  }

  String _extractTitle(String title) {
    return title
        .replaceAll(RegExp(r'\s*$$[^$$]*$$'), '')
        .replaceAll(RegExp(r'\s*\(.*lyric.*\)', caseSensitive: false), '')
        .trim();
  }

  String? _extractArtist(String title) {
    final parts = title.split(RegExp(r'[-–—|]'));
    if (parts.length > 1) return parts[0].trim();
    return null;
  }
}