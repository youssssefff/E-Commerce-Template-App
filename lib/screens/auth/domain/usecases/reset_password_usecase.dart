import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';


class ResetPassword extends UseCaseWithParams<void, ResetPasswordParams> {
  const ResetPassword(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<void> call(ResetPasswordParams params) => repository.resetPassword(
    email: params.email,
    newPassword: params.password,
  );
}

class ResetPasswordParams extends Equatable {
  final String email;
  final String password;

  const ResetPasswordParams.empty() : email = 'test', password = 'test';
  const ResetPasswordParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email,password];

}
