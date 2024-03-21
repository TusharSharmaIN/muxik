import 'package:muxik/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/song_model.dart';

abstract interface class SongRemoteDataSource {
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final SupabaseClient supabaseClient;

  SongRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<SongModel>> getAllSongs() async {
    try {
      final songs = await supabaseClient.from('songs').select('*');
      print("@@@ getAllSongs() result --> ");
      print(songs.toString());
      return songs.map((song) => SongModel.fromJson(song)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
