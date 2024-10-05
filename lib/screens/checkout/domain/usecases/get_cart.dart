import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class GetCart extends UseCaseWithParams<Cart, String> {
  final CartRepository _repository;

  GetCart(this._repository);

  @override
  ResultFuture<Cart> call(String userId) async {
    return await _repository.getCart(userId);
  }
}
