part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

final class SongGetAllSongs extends SongEvent {}
