import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/user_info/domain/Repos/user_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class GetUserPaymentProfile extends UseCaseWithParams<String, String> {
  final UserRepository _repository;

  GetUserPaymentProfile(this._repository);

  @override
  ResultFuture<String> call(String params) async {
    return await _repository.getUserPaymentProfile(params);
  }
}
