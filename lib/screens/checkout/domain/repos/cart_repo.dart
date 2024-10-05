import 'package:dartz/dartz.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/common/models/cart_product.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/utils/constants.dart';

abstract class CartRepository {
  ResultFuture<Cart>getCart(String userId);
  ResultFuture<Cart>getUserCartCount(String userId);
  ResultFuture<Cart>addToCart(String userId, CartProduct product);
  ResultFuture<Cart>removeFromCart(String userId, String productId);
  ResultFuture<Cart>updateCart(String userId, CartProduct product);
  ResultFuture<Cart>modifyProductQuantity(String userId, String productId, int newQuantity);
}
