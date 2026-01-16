import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../api/itunes_dio_client.dart';
import '../../app/di.dart';
import 'models/song.dart';
import 'music_api_interface.dart';

final iTunesRepositoryProvider = Provider<IMusicRepository>((_) {
  return ITunesRepository(apiClient: G<ITunesApiDioClient>(), talker: G<Talker>());
});

class ITunesRepository implements IMusicRepository {
  ITunesRepository({
    required ITunesApiDioClient apiClient,
    required Talker talker,
  })  : _apiClient = apiClient,
        _talker = talker;

  final ITunesApiDioClient _apiClient;
  final Talker _talker;

  @override
  Future<List<Song>> getTracksByArtist(String artistName) async {
    try {
      final artistId = await _apiClient.getArtistId(artistName);

      if (artistId == null) {
        _talker.warning('Artist not found: $artistName');
        return [];
      }

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