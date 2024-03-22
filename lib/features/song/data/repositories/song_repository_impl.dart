import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/song_repository.dart';
import '../data_sources/song_remote_data_source.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource songRemoteDataSource;
  final ConnectionChecker connectionChecker;

  SongRepositoryImpl(
    this.songRemoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, List<Song>>> getAllSongs() async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final songs = await songRemoteDataSource.getAllSongs();
      return right(songs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserFavorites() async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final userFavorites = await songRemoteDataSource.getUserFavorites();
      return right(userFavorites);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> updateUserFavorites(
    List<String> currentFavorite,
    String newToFavorite,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final userFavorites = await songRemoteDataSource.updateUserFavorites(
        currentFavorite,
        newToFavorite,
      );
      return right(userFavorites);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
