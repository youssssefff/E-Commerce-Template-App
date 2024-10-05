class OrderItem {
  final int quantity; // Quantity of the product
  final double price; // Price of the product
  final String? selectedSize; // Selected size of the product
  final String? selectedColor; // Selected color of the product
  final String productName; // Name of the product
  final String productImage; // Image URL of the product
  final double productPrice; // Price of a single unit of the product

  OrderItem({
    required this.quantity,
    required this.price,
    this.selectedSize,
    this.selectedColor,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
      productName: json['productName'],
      productImage: json['productImage'],
      productPrice: json['productPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'price': price,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
    };
  }
}
