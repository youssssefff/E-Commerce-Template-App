import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/common/app/providers/user_provider.dart';

import 'package:shop/screens/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/login_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/register_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/reset_password_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/verify_reset_otp_usecase.dart';
import 'package:shop/screens/auth/domain/usecases/verify_token_usecase.dart';
import 'package:shop/screens/auth/presentation/adapter/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {


  AuthCubit({
    required ForgotPassword forgotPassword,
    required Login login,
    required Register register,
    required VerifyResetOtp verifyResetOtp,
    required VerifyToken verifyToken,
    required ResetPassword resetPassword,
    required this.currentUserProvider,
  })  : _forgotPassword = forgotPassword,
        _login = login,
        _register = register,
        _verifyResetOtp = verifyResetOtp,
        _verifyToken = verifyToken,
        _resetPassword = resetPassword,
        super(const AuthInitial());

  final ForgotPassword _forgotPassword;
  final Login _login;
  final Register _register;
  final VerifyResetOtp _verifyResetOtp;
  final VerifyToken _verifyToken;
  final ResetPassword _resetPassword;
  final UserProvider currentUserProvider;

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    final params = LoginParams(email: email, password: password);
    final result = await _login(params);
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (user) {
        emit(LoggedIn(user));
        currentUserProvider.setUser(user); // Update the current user in your state
      },
    );
  }

  Future<void> register(String email, String password) async {
    emit(const AuthLoading());
    final params = RegisterParams(
      email: email,
      password: password,
      firstName: 'Mohamed',
      lastName: 'Abdo',
      phoneNumber: '9234232348',
    );
    final result = await _register(params);
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (_) => emit(const Registered()),
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(const AuthLoading());
    final result = await _forgotPassword(email);
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (_) => emit(const OTPSent()),
    );
  }

  Future<void> verifyResetOtp(String email, String otp) async {
    emit(const AuthLoading());
    final result = await _verifyResetOtp(VerifyResetOtpParams(email: email, otp: otp));
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (_) => emit(const OTPVerified()),
    );
  }

  Future<void> verifyToken(String token) async {
    emit(const AuthLoading());
    final result = await _verifyToken(token);
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (isValid) {
        emit(TokenVerified(isValid));
        if (!isValid) {
          currentUserProvider.setUser(null);
        }
      },
    );
  }

  Future<void> resetPassword(String newPassword, String email ) async {
    emit(const AuthLoading());
    ResetPasswordParams resetPasswordParams = ResetPasswordParams(email: email, password: newPassword);
    final result = await _resetPassword(resetPasswordParams);  // Ensure _resetPassword is set up properly
    result.fold(
          (failure) => emit(AuthError(failure.toString())),
          (_) => emit(const AuthInitial()),
    );
  }
}
