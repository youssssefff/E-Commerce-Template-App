import 'package:dartz/dartz.dart';
import 'package:shop/common/models/order.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/order/domain/repos/order_repo.dart';

class GetOrderById {
  final OrderRepository repository;

  GetOrderById(this.repository);

  Future<Either<Failure, OrderModel>> call(String orderId) async {
    return await repository.getOrderById(orderId);
  }
}
