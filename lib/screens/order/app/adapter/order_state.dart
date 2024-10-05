import 'package:equatable/equatable.dart';
import 'package:shop/common/models/order.dart';
import 'package:shop/error/failure.dart';

// Abstract base class for OrderState
sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

// Initial state
final class OrderInitial extends OrderState {
  const OrderInitial();
}

// Loading state when fetching orders
class OrderLoading extends OrderState {
  const OrderLoading();
}

// State when orders are successfully fetched
class OrderFetchSuccess extends OrderState {
  final List<OrderModel> orders;

  const OrderFetchSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

// State when an order is successfully fetched by ID
class OrderFetchByIdSuccess extends OrderState {
  final OrderModel order;

  const OrderFetchByIdSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

// Error state to handle failures
class OrderError extends OrderState {
  final Failure failure;

  const OrderError(this.failure);

  @override
  List<Object?> get props => [failure];
}
