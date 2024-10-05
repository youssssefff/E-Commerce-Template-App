class CartProduct {
  final int quantity; // Quantity of the product
  final String selectedSize; // Selected size of the product
  final String selectedColor; // Selected color of the product
  final String productName; // Name of the product
  final String productImage; // Image URL of the product
  final double productPrice; // Price of a single unit of the product
  final DateTime reservationExpiry; // Expiry date for the reservation

  CartProduct({
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.reservationExpiry,
  });

  // Factory method to create a CartProduct instance from a JSON object
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      quantity: json['quantity'] as int,
      selectedSize: json['selectedSize'] as String,
      selectedColor: json['selectedColor'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      reservationExpiry: DateTime.parse(json['reservationExpiry'] as String),
    );
  }

  // Method to convert a CartProduct instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'reservationExpiry': reservationExpiry.toIso8601String(),
    };
  }
}
