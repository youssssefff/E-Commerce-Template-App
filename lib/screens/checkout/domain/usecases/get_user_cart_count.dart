import 'package:dartz/dartz.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';

import 'get_user_cart_count.dart';

class GetUserCartCount {
  final CartRepository cartRepository;

  GetUserCartCount(this.cartRepository);

  Future<Either<Failure, Cart>> call(String userId) async {
    return await cartRepository.getUserCartCount(userId);
  }
}
