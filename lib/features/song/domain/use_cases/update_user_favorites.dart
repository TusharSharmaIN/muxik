import 'package:fpdart/fpdart.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../repositories/song_repository.dart';

class UpdateUserFavorites
    implements UseCase<List<String>, UpdateUserFavoritesParams> {
  final SongRepository songRepository;

  UpdateUserFavorites(this.songRepository);

  @override
  Future<Either<Failure, List<String>>> call(
      UpdateUserFavoritesParams params) async {
    return await songRepository.updateUserFavorites(
      params.currentFavorite,
      params.newToFavorite,
    );
  }
}

class UpdateUserFavoritesParams {
  final List<String> currentFavorite;
  final String newToFavorite;

  UpdateUserFavoritesParams({
    required this.currentFavorite,
    required this.newToFavorite,
  });
}
