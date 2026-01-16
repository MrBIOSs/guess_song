import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../repositories/music_api/models/song.dart';

class ITunesApiDioClient {
  ITunesApiDioClient(Talker talker)
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://itunes.apple.com/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ) {
    _dio.interceptors.add(TalkerDioLogger(talker: talker));
  }

  final Dio _dio;

  Future<int?> getArtistId(String artistName) async {
    final response = await _dio.get(
      'search',
      queryParameters: {
        'term': artistName.trim(),
        'entity': 'musicArtist',
        'limit': 1,
      },
    );
    final data = jsonDecode(response.data.trim());
    final results = (data['results'] as List?) ?? [];

    if (results.isEmpty) return null;

    return results.first['artistId'] as int?;
  }

  Future<List<Song>> getTracksByArtistId(int artistId) async {
    final response = await _dio.get(
      'lookup',
      queryParameters: {
        'id': artistId,
        'entity': 'song',
        'limit': 50,
      },
    );
    final data = jsonDecode(response.data.trim());
    final results = (data['results'] as List?) ?? [];

    return results
        .where((e) => e['wrapperType'] == 'track' && e['kind'] == 'song')
        .map((e) => Song.fromJson(e as Map<String, dynamic>))
        .where((track) => track.audioUrl.isNotEmpty)
        .toList();
  }

  Future<List<Song>> getTracksFromAlbum({
    required String artistName,
    required String albumName
  }) async {
    final response = await _dio.get(
      'search',
      queryParameters: {
        'term': '${artistName.trim()} ${albumName.trim()}',
        'media': 'music',
        'entity': 'song',
        'limit': 50,
      },
    );
    final data = jsonDecode(response.data.trim());
    final results = (data['results'] as List?) ?? [];
    final tracks = results
        .map((e) => Song.fromJson(e as Map<String, dynamic>))
        .where((track) => track.audioUrl.isNotEmpty
          && track.albumName.toLowerCase().contains(albumName.toLowerCase().trim()))
        .toList();

    return tracks;
  }
}