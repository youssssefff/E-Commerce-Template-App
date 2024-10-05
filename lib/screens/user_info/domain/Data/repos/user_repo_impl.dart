
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/screens/user_info/domain/Data/datasources/user_remote_data_src.dart';
import 'package:shop/screens/user_info/domain/Repos/user_repo.dart';
import 'package:shop/utils/constants.dart';



class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSrc remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  ResultFuture<UserModel> getUser(String userId) async {
    try {
      final UserModel user = await remoteDataSource.getUser(userId);
      return Right(user);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  ResultFuture<UserModel> updateUser(String userId, DataMap updatedData) async {
    try {
      UserModel user = await remoteDataSource.updateUser(userId, updatedData);
      return Right(user);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, String>> getUserPaymentProfile(String userId) async {
    try {
      final paymentProfileId = await remoteDataSource.getUserPaymentProfile(userId);
      return Right(paymentProfileId);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }
}
