import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../domain/entities/song.dart';
import '../../domain/use_cases/get_all_songs.dart';
import '../../domain/use_cases/get_user_favorites.dart';
import '../../domain/use_cases/update_user_favorites.dart';

part 'song_event.dart';

part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongs _getAllSongs;
  final GetUserFavorites _getUserFavorites;
  final UpdateUserFavorites _updateUserFavorite;

  SongBloc({
    required GetAllSongs getAllSongs,
    required GetUserFavorites getUserFavorites,
    required UpdateUserFavorites upDateUserFavorite,
  })  : _getAllSongs = getAllSongs,
        _getUserFavorites = getUserFavorites,
        _updateUserFavorite = upDateUserFavorite,
        super(SongInitial()) {
    on<SongEvent>((event, emit) => SongLoading());
    on<SongGetAllSongs>(_onGetAllSongs);
    on<SongGetUserFavorites>(_onGetUserFavorites);
    on<SongUpdateUserFavorites>(_onUpdateUserFavorites);
  }

  void _onGetAllSongs(
    SongGetAllSongs event,
    Emitter<SongState> emit,
  ) async {
    final res = await _getAllSongs(NoParams());
    res.fold(
      (failure) => emit(SongFailure(failure.message)),
      (songs) => emit(SongDisplaySuccess(
        allSongs: songs,
        favoriteSongs: const [],
      )),
    );
  }

  void _onGetUserFavorites(
    SongGetUserFavorites event,
    Emitter<SongState> emit,
  ) async {
    final favorites = await _getUserFavorites(NoParams());
    final allSongs = await _getAllSongs(NoParams());
    allSongs.fold(
      (failure) => emit(SongFailure(failure.message)),
      (allSongs) {
        favorites.fold(
          (failure) => emit(SongFailure(failure.message)),
          (favorites) {
            final List<Song> favoriteSongs = [];
            for (var favSongId in favorites) {
              favoriteSongs.add(
                allSongs.firstWhere((element) => element.id == favSongId),
              );
            }
            return emit(
              SongDisplaySuccess(
                allSongs: allSongs,
                favoriteSongs: favoriteSongs,
              ),
            );
          },
        );
      },
    );
  }

  //  todo: can improve this?
  void _onUpdateUserFavorites(
    SongUpdateUserFavorites event,
    Emitter<SongState> emit,
  ) async {
    final favorites = await _updateUserFavorite(
      UpdateUserFavoritesParams(
        currentFavorite: event.currentFavorite,
        newToFavorite: event.newToFavorite,
      ),
    );
    final allSongs = await _getAllSongs(NoParams());
    allSongs.fold(
      (failure) => emit(SongFailure(failure.message)),
      (allSongs) {
        favorites.fold(
          (failure) => emit(SongFailure(failure.message)),
          (favorites) {
            final List<Song> favoriteSongs = [];
            for (var favSongId in favorites) {
              favoriteSongs.add(
                allSongs.firstWhere((element) => element.id == favSongId),
              );
            }
            return emit(
              SongDisplaySuccess(
                allSongs: allSongs,
                favoriteSongs: favoriteSongs,
              ),
            );
          },
        );
      },
    );
  }
}
