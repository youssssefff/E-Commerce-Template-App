// lib/data_sources/auth_remote_data_source.dart

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:shop/common/app/cache_helper.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/extensions/TokenHeader.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';

import '../../../../../services/injection_container/main.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<bool> verifyToken(String token);

  Future<void> forgotPassword(String email);

  Future<void> verifyResetOtp({
    required String email,
    required String otp,
  });

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body);
        throw ServerException(
          message:
              payload['message'] ?? 'Failed to send forgot password request',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Cache access token if present
        if (data['accessToken'] != null) {
          await sl<CacheHelper>().cacheSessionToken(data['accessToken']);
        }

        // Construct the UserModel
        final user = UserModel.fromJson(data['user'] ?? data);

        // Cache user ID
        if (user.id != null) {
          await sl<CacheHelper>().cacheUserId(user.id!);
        }

        return user;
      } else {
        final payload = jsonDecode(response.body);
        throw ServerException(
          message: payload['message'] ?? 'Failed to login',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        }),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the registration was successful and you get a response body
        final data = jsonDecode(response.body);

        // Cache access token if present
        if (data['accessToken'] != null) {
          await sl<CacheHelper>().cacheSessionToken(data['accessToken']);
        }

        // Optionally, handle user data (assuming the API returns user info after registration)
        final user = UserModel.fromJson(data['user'] ?? data);

        // Cache user ID if necessary
        if (user.id != null) {
          await sl<CacheHelper>().cacheUserId(user.id!);
        }

        // Registration success - you can return the user model or just void
        // return user; (Optional based on your use case)

      } else {
        final payload = jsonDecode(response.body);
        throw ServerException(
          message: payload['message'] ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<bool> verifyToken(String token) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/verify-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true; // Token is valid
      } else {
        return false; // Token is invalid
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  @override
  Future<void> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final otpHeaders = await sl<CacheHelper>().getAuthHeader();
      final response = await client.post(
        Uri.parse('$baseUrl/verify-otp'),
        headers:otpHeaders,
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );
      //await NetworkUtils.renewToken(response, context);
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body);
        throw ServerException(
          message: payload['message'] ?? 'OTP verification failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }



  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body);
        throw ServerException(
          message: payload['message'] ?? 'Failed to reset password',
          statusCode: response.statusCode,
        );
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

}
