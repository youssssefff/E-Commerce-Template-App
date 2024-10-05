
import 'package:equatable/equatable.dart';
import 'package:shop/common/models/user.dart';

sealed class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState{
  const AuthInitial();
}

final class AuthLoading extends AuthState{
  const AuthLoading();
}

final class  OTPSent extends AuthState{
  const OTPSent();
}

final class  LoggedIn extends AuthState{
  const LoggedIn(this.user);

  final User user;
  @override
  List<Object?> get props => [user];
}

final class Registered extends AuthState{
  const Registered();
}

final class ResetPasswordSuccess extends AuthState{
  const ResetPasswordSuccess();
}

final class  OTPVerified extends AuthState{
  const OTPVerified();
}

final class TokenVerified extends AuthState{
  const TokenVerified(this.isValid);

  final bool isValid;
  @override
  List<Object?> get props => [isValid];
}

final class AuthError extends AuthState{
  const AuthError(this.message);

  final String message;
  @override
  List<Object?> get props => [message];
}