import 'package:dartz/dartz.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/common/models/cart_product.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';
import 'package:shop/utils/constants.dart';

class AddToCart {
  final CartRepository cartRepository;

  AddToCart(this.cartRepository);

  ResultFuture<Cart> call(String userId, CartProduct cartProduct) async {
    return await cartRepository.addToCart(userId, cartProduct);
  }
}
