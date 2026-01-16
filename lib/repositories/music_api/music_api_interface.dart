import 'models/song.dart';

abstract interface class IMusicRepository {
  Future<List<Song>> getTracksByArtist(String artistName);
  Future<List<Song>> getTracksFromAlbum({required String artistName, required String albumName});
}