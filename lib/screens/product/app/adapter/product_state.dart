import 'package:equatable/equatable.dart';
import 'package:shop/common/models/product.dart';
import 'package:shop/error/failure.dart';

// Base class for Product States
sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// Initial State
final class ProductInitial extends ProductState {
  const ProductInitial();
}

// Get Products States
class GetProductsLoading extends ProductState {
  const GetProductsLoading();
}

class GetProductsSuccess extends ProductState {
  final List<Product> products;

  const GetProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

// Search Products States
class SearchProductsLoading extends ProductState {
  const SearchProductsLoading();
}

class SearchProductsSuccess extends ProductState {
  final List<Product> products;

  const SearchProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

// Product Error State
class ProductError extends ProductState {
  final Failure failure;

  const ProductError(this.failure);

  @override
  List<Object?> get props => [failure];
}
