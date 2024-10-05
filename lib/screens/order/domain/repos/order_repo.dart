import 'package:dartz/dartz.dart';
import 'package:shop/common/models/order.dart';
import 'package:shop/error/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getUserOrders(String userId);
  Future<Either<Failure, OrderModel>> getOrderById(String orderId);
}
