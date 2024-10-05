// lib/repositories/auth_repository_impl.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/utils/constants.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/data/datasources/auth_remote_data_source.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/screens/auth/domain/repos/AuthRepository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final String baseUrl;
  final AuthRemoteDataSource _remoteDataSource ;

  AuthRepositoryImplementation(this.baseUrl, this._remoteDataSource);

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      await _remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(email: email, newPassword: newPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await _remoteDataSource.verifyResetOtp(email: email, otp: otp);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyToken(String token) async {
    try {
      final result = await _remoteDataSource.verifyToken(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

