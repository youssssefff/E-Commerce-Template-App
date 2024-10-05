import 'package:equatable/equatable.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';

sealed class AuthUserState extends Equatable {
  const AuthUserState();

  @override
  List<Object?> get props => [];
}

final class AuthUserInitial extends AuthUserState {
  const AuthUserInitial();
}

class GetUserLoading extends AuthUserState {
  const GetUserLoading();
}

class GetUserSuccess extends AuthUserState {
  final User user;

  const GetUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}


// Update User Specific States
class UpdateUserLoading extends AuthUserState {
  const UpdateUserLoading();
}

class UpdateUserSuccess extends AuthUserState {
  final UserModel user;

  const UpdateUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}


// Get User Payment Profile States
class GetPaymentProfileLoading extends AuthUserState {
  const GetPaymentProfileLoading();
}

class GetPaymentProfileSuccess extends AuthUserState {
  final String paymentProfile;

  const GetPaymentProfileSuccess(this.paymentProfile);

  @override
  List<Object?> get props => [paymentProfile];
}

class AuthUserError extends AuthUserState {
  final Failure failure;

  const AuthUserError(this.failure);

  @override
  List<Object?> get props => [failure];
}
