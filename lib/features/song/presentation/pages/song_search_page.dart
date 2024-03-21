import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/route/app_router.dart';
import '../../../../core/theme/theme/app_colors.dart';
import '../../domain/entities/song.dart';

class SongSearchPage extends StatefulWidget {
  final List<Song> songs;

  const SongSearchPage({
    super.key,
    required this.songs,
  });

  @override
  State<SongSearchPage> createState() => _SongSearchPageState();
}

class _SongSearchPageState extends State<SongSearchPage> {
  TextEditingController editingController = TextEditingController();
  List<Song> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    filteredSongs = widget.songs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColors.whiteColor,
                hintText: 'Search for Music',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.chineseBlack,
                    ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.chineseBlack,
                  size: 22,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: AppColors.gradient1,
                    width: 1,
                  ),
                ),
              ),
              style: const TextStyle(color: AppColors.backgroundColor),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSongs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SearchedListTile(
                        song: filteredSongs[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    setState(
      () {
        filteredSongs = widget.songs
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
    );
  }
}

class SearchedListTile extends StatelessWidget {
  final Song song;

  const SearchedListTile({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.songDetails, extra: song);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                song.imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.album,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
