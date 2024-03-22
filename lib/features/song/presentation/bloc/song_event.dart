part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

final class SongGetAllSongs extends SongEvent {}

final class SongGetUserFavorites extends SongEvent {}

final class SongUpdateUserFavorites extends SongEvent {
  final List<String> currentFavorite;
  final String newToFavorite;

  SongUpdateUserFavorites({
    required this.currentFavorite,
    required this.newToFavorite,
  });
}