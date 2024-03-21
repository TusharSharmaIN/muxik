import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../../../core/theme/theme/app_colors.dart';
import '../../data/models/song_model.dart';
import '../widgets/song_player_widget.dart';
import '../widgets/seekbar_data.dart';

class SongDetailsPage extends StatefulWidget {
  final SongModel song;

  const SongDetailsPage({super.key, required this.song});

  @override
  State<SongDetailsPage> createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(widget.song.url),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (
          Duration position,
          Duration bufferedPosition,
          Duration? duration,
        ) {
          return SeekBarData(
            position,
            bufferedPosition,
            duration ?? Duration.zero,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.song.imageUrl,
              fit: BoxFit.cover,
            ),
            const BackgroundFilter(),
            SongPlayerWidget(
              song: widget.song,
              seekBarDataStream: _seekBarDataStream,
              audioPlayer: audioPlayer,
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.whiteColor,
              AppColors.whiteColor.withOpacity(0.5),
              AppColors.whiteColor.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradient2,
              AppColors.backgroundColor,
            ],
          ),
        ),
      ),
    );
  }
}
