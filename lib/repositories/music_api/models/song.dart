class Song {
  Song({
    required this.id,
    required this.title,
    required this.artistName,
    required this.albumName,
    required this.coverUrl,
    required this.audioUrl,
  });

  final int id;
  final String title;
  final String artistName;
  final String albumName;
  final String coverUrl;
  final String audioUrl;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['trackId'] as int? ?? 0,
      title: json['trackName'] as String? ?? 'Unknown Track',
      artistName: json['artistName'] as String? ?? 'Unknown Artist',
      albumName: json['collectionName'] as String? ?? 'Unknown Album',
      coverUrl: json['artworkUrl100'] as String? ?? '',
      audioUrl: json['previewUrl'] as String? ?? '',
    );
  }
}