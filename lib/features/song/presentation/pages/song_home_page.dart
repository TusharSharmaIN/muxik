import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/theme/app_colors.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../domain/entities/song.dart';
import '../bloc/song_bloc.dart';
import '../widgets/song_card_widget.dart';

class SongHomePage extends StatefulWidget {
  final String? userFullName;

  const SongHomePage({super.key, this.userFullName});

  @override
  State<SongHomePage> createState() => _SongHomePageState();
}

class _SongHomePageState extends State<SongHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(SongGetAllSongs());
    context.read<SongBloc>().add(SongGetUserFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.userFullName.helloUser(),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<SongBloc, SongState>(
            listener: (context, state) {
              if (state is SongFailure) {
                showSnackBar(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is SongLoading) {
                return const Loader();
              }
              if (state is SongDisplaySuccess) {
                return Column(
                  children: [
                    DiscoverMusic(songs: state.allSongs),

                    /// for all music
                    MusicLibrary(
                      title: "All Musics",
                      songs: state.allSongs,
                      onFavorite: () {},
                    ),

                    ///  For favorite
                    MusicLibrary(
                      title: "Your Favorite Picks",
                      songs: state.favoriteSongs,
                      isFavorite: true,
                      onFavorite: () {
                        print("@@@@ CLIKED ONFAV");
                        final favoriteSongs =
                        state.favoriteSongs.map((song) => song.id).toList();
                        context.read<SongBloc>().add(
                          SongUpdateUserFavorites(
                            currentFavorite: favoriteSongs,
                            newToFavorite: state.allSongs[7].id,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

/// for searching only, but not working as of now
class DiscoverMusic extends StatefulWidget {
  final List<Song> songs;

  const DiscoverMusic({super.key, required this.songs});

  @override
  State<DiscoverMusic> createState() => _DiscoverMusicState();
}

class _DiscoverMusicState extends State<DiscoverMusic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enjoy your favorite music',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.gradient2,
                ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              context.push(
                AppRoutes.songSearch,
                extra: widget.songs,
              );
            },
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(
                    color: AppColors.gradient1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.chineseBlack,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search for Music',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.chineseBlack,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicLibrary extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final Function onFavorite;

  const MusicLibrary({
    super.key,
    required this.songs,
    required this.title,
    this.isFavorite = false,
    required this.onFavorite,
  });

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.gradient2,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return SongCardWidget(
                  song: songs[index],
                  isFavorite: isFavorite,
                  onFavorite: onFavorite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
