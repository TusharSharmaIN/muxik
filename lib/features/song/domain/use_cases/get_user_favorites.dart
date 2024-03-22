import 'package:fpdart/fpdart.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../repositories/song_repository.dart';

class GetUserFavorites implements UseCase<List<String>, NoParams> {
  final SongRepository songRepository;

  GetUserFavorites(this.songRepository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await songRepository.getUserFavorites();
  }
}
