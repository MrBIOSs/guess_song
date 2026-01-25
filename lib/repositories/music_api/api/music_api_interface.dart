import '../models/song.dart';

abstract interface class IMusicApi {
  Future<int?> getArtistId(String artistName);
  Future<List<Song>> getTracksByArtistId(int artistId);
  Future<List<Song>> getTracksFromAlbum({
    required String artistName,
    required String albumName,
  });
}