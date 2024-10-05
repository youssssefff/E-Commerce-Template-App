import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/screens/user_info/domain/Repos/user_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class GetUser extends UseCaseWithParams<User, String> {
  final UserRepository _repository;

  GetUser(this._repository);

  @override
  ResultFuture<UserModel> call(params) async {
    return await _repository.getUser(params);
  }
}
