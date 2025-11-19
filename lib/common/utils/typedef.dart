import 'package:fpdart/fpdart.dart';
import 'package:ia_project/common/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure,T>>;
typedef FutureVoid = FutureEither<void>;