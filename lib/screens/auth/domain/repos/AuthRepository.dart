// lib/repositories/auth_repository.dart
import 'package:flutter/material.dart';
import 'package:shop/common/models/user.dart';

import '../../../../utils/constants.dart';

abstract class AuthRepository {
  ResultFuture<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  });

  ResultFuture<User>  login({
    required String email,
    required String password,
  });

  ResultFuture<bool>  verifyToken(String token);

  ResultFuture<void>  forgotPassword(String email);

  ResultFuture<void>  verifyResetOtp({
    required String email,
    required String otp,
  });

   ResultFuture<void> resetPassword({
    required String email,
    required String newPassword,
  });
}


