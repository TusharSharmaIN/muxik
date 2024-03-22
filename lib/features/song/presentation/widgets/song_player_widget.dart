import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/theme/theme/app_colors.dart';
import '../../data/models/song_model.dart';
import 'player_button.dart';
import 'seekbar_data.dart';

class SongPlayerWidget extends StatelessWidget {
  final SongModel song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final bool isFavorite;
  final Function onFavorite;

  const SongPlayerWidget({
    super.key,
    required this.song,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    this.isFavorite = false,
    required this.onFavorite,
  }) : _seekBarDataStream = seekBarDataStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    song.album,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: AppColors.rustyRed,
                  size: 28,
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final positionData = snapshot.data;
                return ProgressBar(
                  barHeight: 8,
                  baseBarColor: AppColors.whiteColor.withOpacity(0.2),
                  bufferedBarColor: AppColors.whiteColor.withOpacity(0.5),
                  progressBarColor: AppColors.whiteColor.withOpacity(0.90),
                  thumbColor: AppColors.whiteColor,
                  timeLabelTextStyle: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                  timeLabelPadding: 8,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: audioPlayer.seek,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          PlayerButton(audioPlayer: audioPlayer),
        ],
      ),
    );
  }
}
