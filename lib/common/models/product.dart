// For demo only
import 'package:shop/utils/constants.dart';
// domain/entities/product.dart
import 'package:equatable/equatable.dart';

enum GenderAgeCategory { men, women, unisex, kids }

class Product extends Equatable {
  final String name;
  final String description;
  final int price;
  final int rating;
  final String color;
  final int? numberOfRatings;
  final int? countInStock;
  final bool published;
  final GenderAgeCategory genderAgeCategory;
  final bool newArrival;
  final bool bestSeller;
  final String style;
  final String size;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.color,
    this.numberOfRatings,
    this.countInStock,
    required this.published,
    required this.genderAgeCategory,
    required this.newArrival,
    required this.bestSeller,
    required this.style,
    required this.size,
  });

  // Factory method to create a Product from JSON (from your API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      rating: json['rating'] ?? 0,
      color: json['color'] ?? '',
      numberOfRatings: json['numberOfRatings'],
      countInStock: json['countInStock'],
      published: json['published'] ?? false,
      genderAgeCategory: _genderAgeCategoryFromString(json['genderAgeCategory']),
      newArrival: json['newArrival'] ?? false,
      bestSeller: json['bestSeller'] ?? false,
      style: json['style'] ?? '',
      size: json['size'] ?? '',
    );
  }

  // Helper function to convert genderAgeCategory string to enum
  static GenderAgeCategory _genderAgeCategoryFromString(String? value) {
    switch (value) {
      case 'men':
        return GenderAgeCategory.men;
      case 'women':
        return GenderAgeCategory.women;
      case 'unisex':
        return GenderAgeCategory.unisex;
      case 'kids':
        return GenderAgeCategory.kids;
      default:
        return GenderAgeCategory.unisex;
    }
  }

  // Method to convert Product entity back to JSON (for PUT/POST requests)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'color': color,
      'numberOfRatings': numberOfRatings,
      'countInStock': countInStock,
      'published': published,
      'genderAgeCategory': genderAgeCategory.name, // Convert enum to string
      'newArrival': newArrival,
      'bestSeller': bestSeller,
      'style': style,
      'size': size,
    };
  }

  @override
  List<Object?> get props => [
    name,
    description,
    price,
    rating,
    color,
    numberOfRatings,
    countInStock,
    published,
    genderAgeCategory,
    newArrival,
    bestSeller,
    style,
    size,
  ];
}




















////////////////////////////TEMP////////////////
class ProductModel {
  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;

  ProductModel({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
  });
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    image: productDemoImg1,
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfetDiscount: 420,
    dicountpercent: 20,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
];
List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];

List<ProductModel> kidsProducts = [
  ProductModel(
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 590.36,
    dicountpercent: 24,
  ),
  ProductModel(
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfetDiscount: 360,
    dicountpercent: 20,
  ),
  ProductModel(
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];
//////////////////////////////////NOT USEFUL/////////////////

