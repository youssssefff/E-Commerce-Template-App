import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';

class VerifyToken extends UseCaseWithParams<bool, String> {
  const VerifyToken(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<bool> call(String params) => repository.verifyToken(params);
}
