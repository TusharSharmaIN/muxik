import 'package:fpdart/fpdart.dart';

import '../../../../core/common/use_case/use_case.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class UserLogOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logOut();
  }
}