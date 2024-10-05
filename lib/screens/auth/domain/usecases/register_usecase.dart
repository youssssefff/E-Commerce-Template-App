import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';

class Register extends UseCaseWithParams<void, RegisterParams> {
  const Register(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<void> call(RegisterParams params) => repository.register(
    firstName: params.firstName,
    lastName: params.lastName,
    email: params.email,
    password: params.password,
    phoneNumber: params.phoneNumber,
  );
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password, phoneNumber];
}
