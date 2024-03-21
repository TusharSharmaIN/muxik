import 'package:fpdart/fpdart.dart';
import 'package:muxik/core/error/failures.dart';

import '../entities/song.dart';

abstract interface class SongRepository {
  Future<Either<Failure, List<Song>>> getAllSongs();
}