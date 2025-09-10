import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HiddenYoutubePlayer extends StatefulWidget {
  const HiddenYoutubePlayer({
    super.key,
    required this.videoId,
    this.startAt = 0,
    this.endAt = 10,
  });
  final String videoId;
  final int startAt;
  final int endAt;

  @override
  State<HiddenYoutubePlayer> createState() => _HiddenYoutubePlayerState();
}

class _HiddenYoutubePlayerState extends State<HiddenYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        disableDragSeek: true,
        enableCaption: false,
        hideControls: true,
        showLiveFullscreenButton: false,
      ),
    );

    _controller.cue(widget.videoId, startAt: widget.startAt, endAt: widget.endAt);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}