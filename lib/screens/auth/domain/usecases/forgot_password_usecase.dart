// lib/usecases/forgot_password_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this.repository);

  final AuthRepository repository;


  @override
  ResultFuture<void> call(String params) => repository.forgotPassword(params);
}
