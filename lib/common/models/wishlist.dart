class WishlistProduct {
  String? productId;
  String? title;
  double? price;
  String? imageUrl;

  WishlistProduct({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  // Factory method to create a WishlistProduct from JSON
  factory WishlistProduct.fromJson(Map<String, dynamic> json) {
    return WishlistProduct(
      productId: json['productId'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  // Method to convert WishlistProduct to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
  // Convert WishlistProduct to Map
  Map<String, dynamic> toMap() => {
    'id': productId,
    'title': title,
    'price': price,
    'imageUrl': imageUrl,
  };

  // Convert Map to WishlistProduct
  factory WishlistProduct.fromMap(Map<String, dynamic> map) => WishlistProduct(
    productId: map['productId'],
    title: map['title'],
    price: map['price'],
    imageUrl: map['imageUrl'],
  );
}
