import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../domain/entities/song.dart';
import '../../domain/use_cases/get_all_songs.dart';

part 'song_event.dart';

part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongs _getAllSongs;

  SongBloc({required GetAllSongs getAllSongs})
      : _getAllSongs = getAllSongs,
        super(SongInitial()) {
    on<SongEvent>((event, emit) => SongLoading());
    on<SongGetAllSongs>(_onGetAllSongs);
  }

  void _onGetAllSongs(
    SongGetAllSongs event,
    Emitter<SongState> emit,
  ) async {
    final res = await _getAllSongs(NoParams());
    res.fold(
      (failure) => emit(SongFailure(failure.message)),
      (songs) => emit(SongDisplaySuccess(songs)),
    );
  }
}
