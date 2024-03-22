part of 'song_bloc.dart';

@immutable
sealed class SongState {}

final class SongInitial extends SongState {}

final class SongLoading extends SongState {}

final class SongFailure extends SongState {
  final String error;

  SongFailure(this.error);
}

final class SongSuccess extends SongState {}

final class SongDisplaySuccess extends SongState {
  final List<Song> allSongs;
  final List<Song> favoriteSongs;
  SongDisplaySuccess({required this.allSongs, required this.favoriteSongs});
}

final class SongGetFavoritesSuccess extends SongState {
  final List<Song> songs;
  SongGetFavoritesSuccess(this.songs);
}