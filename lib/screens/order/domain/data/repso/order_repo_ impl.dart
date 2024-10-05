import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/order.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/order/domain/data/datasource/order_remote_data_src.dart';
import 'package:shop/screens/order/domain/repos/order_repo.dart';

class OrderRepositoryImpl implements OrderRepository{
  final OrderRemoteDataSrc remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders(String userId) async {
    try {
      final orders = await remoteDataSource.getUserOrders(userId);
      return Right(orders);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderById(String orderId) async {
    try {
      final order = await remoteDataSource.getOrderById(orderId);
      return Right(order);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }
}
