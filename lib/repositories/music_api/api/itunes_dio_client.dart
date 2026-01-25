import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../models/song.dart';
import 'music_api_interface.dart';

class ITunesApiDioClient implements IMusicApi {
  ITunesApiDioClient(Talker talker)
      : _talker = talker, _dio = Dio(
    BaseOptions(
      baseUrl: 'https://itunes.apple.com/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ) {
    _dio.interceptors.add(TalkerDioLogger(talker: talker));
  }

  final Dio _dio;
  final Talker _talker;

  @override
  Future<int?> getArtistId(String artistName) async {
    try {
      final response = await _dio.get(
        'search',
        queryParameters: {
          'term': artistName.trim(),
          'entity': 'musicArtist',
          'media': 'music',
          'limit': 1,
        },
      );

      final data = _parseResponse(response);
      final results = (data['results'] as List?) ?? [];

      if (results.isEmpty) return null;

      return results.first['artistId'] as int?;
    } on DioException  catch (e, st) {
      _talker.handle(e, st, 'Failed to fetch artist id');
      rethrow;
    }
  }

  @override
  Future<List<Song>> getTracksByArtistId(int artistId) async {
    try {
      final response = await _dio.get(
        'lookup',
        queryParameters: {
          'id': artistId,
          'entity': 'song',
          'limit': 50,
        },
      );
      final data = _parseResponse(response);
      final results = (data['results'] as List?) ?? [];

      return results
          .where((e) => e['wrapperType'] == 'track' && e['kind'] == 'song')
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .where((track) => track.audioUrl.isNotEmpty)
          .toList();
    } on DioException  catch (e, st) {
      _talker.handle(e, st, 'Failed to fetch tracks by artist');
      rethrow;
    }
  }

  @override
  Future<List<Song>> getTracksFromAlbum({
    required String artistName,
    required String albumName
  }) async {
    try {
      final response = await _dio.get(
        'search',
        queryParameters: {
          'term': '${artistName.trim()} ${albumName.trim()}',
          'media': 'music',
          'entity': 'song',
          'limit': 50,
        },
      );

      final data = _parseResponse(response);
      final results = (data['results'] as List?) ?? [];
      final tracks = results
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .where((track) => track.audioUrl.isNotEmpty
            && track.albumName.toLowerCase().startsWith(albumName.toLowerCase().trim()))
          .toList();

      return tracks;
    } on DioException  catch (e, st) {
      _talker.handle(e, st, 'Failed to fetch tracks from album');
      rethrow;
    }
  }

  Map<String, dynamic> _parseResponse(Response response) {
    final data = response.data;

    if (data is Map<String, dynamic>) return data;
    if (data is String) {
      return jsonDecode(data) as Map<String, dynamic>;
    }

    throw FormatException('Unexpected response format: ${data.runtimeType}');
  }
}