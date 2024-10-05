import 'package:equatable/equatable.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/error/failure.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartUpdating extends CartState {
  const CartUpdating();
}

class CartSuccess extends CartState {
  final Cart cart;

  const CartSuccess(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final Failure failure;

  const CartError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class CartCountLoading extends CartState {
  const CartCountLoading();
}

class CartCountSuccess extends CartState {
  final int count;

  const CartCountSuccess(this.count);

  @override
  List<Object?> get props => [count];
}
