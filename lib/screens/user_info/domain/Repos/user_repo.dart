import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/utils/constants.dart';

abstract class UserRepository {
  ResultFuture<UserModel> getUser(String userId);
  ResultFuture<UserModel> updateUser(
      String userId,
      DataMap updatedData
      );
  ResultFuture<String> getUserPaymentProfile(String userId);
}