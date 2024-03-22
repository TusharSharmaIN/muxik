import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/song.dart';

abstract interface class SongRepository {
  Future<Either<Failure, List<Song>>> getAllSongs();

  Future<Either<Failure, List<String>>> getUserFavorites();

  Future<Either<Failure, List<String>>> updateUserFavorites(
    List<String> currentFavorite,
    String newToFavorite,
  );
}
