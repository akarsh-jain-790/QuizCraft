import 'package:fpdart/fpdart.dart';
import 'package:quiz_craft/helper/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
