import 'package:shop/common/models/cart.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';

import '../../../../utils/constants.dart';

class RemoveFromCart {
  final CartRepository cartRepository;

  RemoveFromCart(this.cartRepository);

  ResultFuture<Cart> call(String userId, String productId) async {
    return await cartRepository.removeFromCart(userId, productId);
  }
}
