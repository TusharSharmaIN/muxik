import 'package:muxik/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/song_model.dart';

abstract interface class SongRemoteDataSource {
  Session? get currentUserSession;

  Future<List<SongModel>> getAllSongs();

  Future<List<String>> getUserFavorites();

  Future<List<String>> updateUserFavorites(
    List<String> currentFavorite,
    String newToFavorite,
  );
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final SupabaseClient supabaseClient;

  SongRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<List<SongModel>> getAllSongs() async {
    try {
      final songs = await supabaseClient.from('songs').select('*');
      return songs.map((song) => SongModel.fromJson(song)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getUserFavorites() async {
    try {
      if (currentUserSession != null) {
        final userFavorites =
            await supabaseClient.from('profiles').select('favorite_songs').eq(
                  'id',
                  currentUserSession!.user.id,
                );
        if (userFavorites.isNotEmpty) {
          return List<String>.from(userFavorites.first["favorite_songs"]);
        }
        return [];
      }
      return [];
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> updateUserFavorites(
    List<String> currentFavorite,
    String newToFavorite,
  ) async {
    try {
      if (currentUserSession != null) {
        final updatedFavorites = await supabaseClient
            .from('profiles')
            .update({
              'favorite_songs': [...currentFavorite, newToFavorite]
            })
            .eq('id', currentUserSession!.user.id)
            .select();
        if (updatedFavorites.isNotEmpty) {
          return List<String>.from(updatedFavorites.first["favorite_songs"]);
        }
        return [];
      }
      return [];
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
