import 'package:fpdart/fpdart.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../entities/song.dart';
import '../repositories/song_repository.dart';

class GetAllSongs implements UseCase<List<Song>, NoParams> {
  final SongRepository songRepository;

  GetAllSongs(this.songRepository);
  @override
  Future<Either<Failure, List<Song>>> call(NoParams params) async {
    return await songRepository.getAllSongs();
  }
}