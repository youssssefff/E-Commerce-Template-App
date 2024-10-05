// lib/usecases/usecase.dart

import 'package:dartz/dartz.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();
  ResultFuture<Type> call();
}
