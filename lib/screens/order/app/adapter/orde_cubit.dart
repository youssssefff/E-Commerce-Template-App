import 'package:bloc/bloc.dart';
import 'package:shop/screens/order/domain/usecases/get_user_orders.dart';
import 'package:shop/screens/order/domain/usecases/get_order_by_id.dart';
import 'package:shop/screens/order/app/adapter/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required GetUserOrders getUserOrders,
    required GetOrderById getOrderById,
  })  : _getUserOrders = getUserOrders,
        _getOrderById = getOrderById,
        super(const OrderInitial());

  final GetUserOrders _getUserOrders;
  final GetOrderById _getOrderById;

  // Fetch user orders by user ID
  Future<void> fetchUserOrders(String userId) async {
    emit(const OrderLoading()); // Emit loading state

    final result = await _getUserOrders(userId);

    result.fold(
          (failure) => emit(OrderError(failure)), // Emit error state
          (orders) {
        emit(OrderFetchSuccess(orders)); // Emit success state
      },
    );
  }

  // Fetch order by ID
  Future<void> fetchOrderById(String orderId) async {
    emit(const OrderLoading()); // Emit loading state

    final result = await _getOrderById(orderId);

    result.fold(
          (failure) => emit(OrderError(failure)), // Emit error state
          (order) {
        emit(OrderFetchByIdSuccess(order)); // Emit success state
      },
    );
  }
}
