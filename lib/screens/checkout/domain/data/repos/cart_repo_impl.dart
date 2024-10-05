import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/common/models/cart_product.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/checkout/domain/data/datasource/cart_remote_data_src.dart';
import 'package:shop/screens/checkout/domain/repos/cart_repo.dart';
import 'package:shop/utils/constants.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Cart>> getCart(String userId) async {
    try {
      final Cart cart = await remoteDataSource.getCart(userId);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, Cart>> getUserCartCount(String userId) async {
    try {
      final Cart cart = await remoteDataSource.getUserCartCount(userId);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, Cart>> addToCart(String userId, CartProduct product) async {
    try {
      final Cart cart = await remoteDataSource.addToCart(userId, product);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(String userId, String productId) async {
    try {
      final Cart cart = await remoteDataSource.removeFromCart(userId, productId);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, Cart>> updateCart(String userId, CartProduct product) async {
    try {
      final Cart cart = await remoteDataSource.updateCart(userId, product);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, Cart>> modifyProductQuantity(String userId, String productId, int newQuantity) async {
    try {
      final Cart cart = await remoteDataSource.modifyProductQuantity(userId, productId, newQuantity);
      return Right(cart);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }
}
