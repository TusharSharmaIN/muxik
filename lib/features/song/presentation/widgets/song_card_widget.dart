import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muxik/core/route/app_router.dart';

import '../../../../core/theme/theme/app_colors.dart';
import '../../domain/entities/song.dart';

class SongCardWidget extends StatelessWidget {
  const SongCardWidget({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.songDetails, extra: song);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2 * 8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2 * 8.0),
                image: DecorationImage(
                  image: NetworkImage(
                    song.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 8 * 8,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2 * 8.0),
                color: AppColors.blackColor.withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      song.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.whiteColor,
                          ),
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      song.album,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.whiteColor,
                          ),
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
