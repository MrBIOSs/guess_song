import 'package:talker_flutter/talker_flutter.dart';
import 'api/music_api_interface.dart';
import 'models/song.dart';
import 'music_api_interface.dart';

class ITunesRepository implements IMusicRepository {
  ITunesRepository({
    required IMusicApi  apiClient,
    required Talker talker,
  })  : _apiClient = apiClient, _talker = talker;

  final IMusicApi  _apiClient;
  final Talker _talker;

  @override
  Future<List<Song>> getTracksByArtist(String artistName) async {
    try {
      final artistId = await _apiClient.getArtistId(artistName);

      if (artistId == null) return [];

      return await _apiClient.getTracksByArtistId(artistId);
    } catch (e, st) {
      _talker.handle(e, st, 'Error fetching tracks by artist: $artistName');
      rethrow;
    }
  }

  @override
  Future<List<Song>> getTracksFromAlbum({
    required String artistName,
    required String albumName
  }) async {
    try {
      return await _apiClient.getTracksFromAlbum(artistName: artistName, albumName: albumName);
    } catch (e, st) {
      _talker.handle(e, st, 'Error fetching album tracks: $albumName');
      rethrow;
    }
  }
}