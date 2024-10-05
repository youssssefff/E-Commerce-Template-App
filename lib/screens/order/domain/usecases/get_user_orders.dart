import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/order/domain/repos/order_repo.dart';
import 'package:shop/common/models/order.dart';
import 'package:shop/utils/constants.dart';

class GetUserOrders {
  final OrderRepository repository;

  GetUserOrders(this.repository);

  Future<Either<Failure, List<OrderModel>>> call(String userId) async {
    return await repository.getUserOrders(userId);
  }
}
