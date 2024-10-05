import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/screens/user_info/domain/Repos/user_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  final UserRepository _repository;

  UpdateUser(this._repository);

  @override
  ResultFuture<UserModel> call(UpdateUserParams params) async {
    return await _repository.updateUser(params.userId, params.updatedData);
  }
}
class UpdateUserParams {
  final String userId;
  final DataMap updatedData;

  UpdateUserParams({
    required this.userId,
    required this.updatedData,
  });
}

