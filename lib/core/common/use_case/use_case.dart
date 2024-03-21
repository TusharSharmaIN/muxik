import 'package:fpdart/fpdart.dart';

import '../../error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

//  why? for use cases which do not requires params to make a call
class NoParams {}
