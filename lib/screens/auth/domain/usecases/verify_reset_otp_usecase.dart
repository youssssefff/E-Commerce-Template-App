import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';
import 'package:shop/usecase/usecase.dart';

class VerifyResetOtp extends UseCaseWithParams<void, VerifyResetOtpParams> {
  const VerifyResetOtp(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<void> call(VerifyResetOtpParams params) => repository.verifyResetOtp(
    email: params.email,
    otp: params.otp,
  );
}

class VerifyResetOtpParams extends Equatable {
  final String email;
  final String otp;

  VerifyResetOtpParams({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}
