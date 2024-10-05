import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';

class Login extends UseCaseWithParams<User, LoginParams> {
  const Login(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<User> call(LoginParams params) => repository.login(
    email: params.email,
    password: params.password,
  );
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  LoginParams.empty() : email = 'test', password = 'test';
  LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email,password];

}
