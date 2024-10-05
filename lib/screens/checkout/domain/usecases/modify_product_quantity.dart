import 'package:shop/common/models/cart.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';

import '../../../../utils/constants.dart';

class ModifyProductQuantity {
  final CartRepository cartRepository;

  ModifyProductQuantity(this.cartRepository);

  ResultFuture<Cart> call(String userId, String productId, int newQuantity) async {
    return await cartRepository.modifyProductQuantity(userId, productId, newQuantity);
  }
}
