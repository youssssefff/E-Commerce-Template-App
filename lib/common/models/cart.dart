import 'package:shop/common/models/cart_product.dart';

class Cart {
  final String id; // Unique identifier for the cart
  final String userId; // ID of the user who owns the cart
  final List<CartProduct> products; // List of products in the cart

  Cart({
    required this.id,
    required this.userId,
    required this.products,
  });

  // Calculate total price of the cart.
  double get totalPrice => products.fold(
    0,
        (sum, product) => sum + (product.productPrice * product.quantity),
  );

  // Factory method to create a Cart instance from a JSON object
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as String,
      userId: json['userId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((product) => CartProduct.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert a Cart instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
