import 'package:shop/common/models/address.dart';
import 'package:shop/common/models/wishlist.dart';



class User {
  String? id;
  //String? image;
  String? paymentCustomerId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  Address? address; // Address model
  String? phoneNumber;
  bool isAdmin;
  int? resetPasswordOtp;
  DateTime? resetPasswordOtpExpires;
  List<WishlistProduct>? wishlist; // New wishlist field as List<WishlistProduct>

  User({
    required this.id,
    //this.image,
    this.paymentCustomerId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    this.address,
    required this.phoneNumber,
    this.isAdmin = false,
    this.wishlist, // Initialize wishlist as List<WishlistProduct>
  });

  // Factory method to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    // Create the address object manually from individual fields
    Address? address = Address(
      street: json['street'],
      apartment: json['apartment'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postalCode'],
    );

    // Parse wishlist if available, otherwise set an empty list or null
    List<WishlistProduct>? wishlist = json['wishlist'] != null
        ? (json['wishlist'] as List)
        .map((item) => WishlistProduct.fromJson(item))
        .toList()
        : [];

    return User(
      id:  json['id'],
      //image: json['image'],
      paymentCustomerId: json['paymentCustomerId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      address: address,
      phoneNumber: json['phoneNumber'],
      isAdmin: json['isAdmin'] ?? false,

      wishlist: wishlist, // Assign the wishlist as List<WishlistProduct>
    );
  }

  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      //'image': image,
      'paymentCustomerId': paymentCustomerId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'street': address?.street,
      'apartment': address?.apartment,
      'city': address?.city,
      'country': address?.country,
      'postalCode': address?.postalCode,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'wishlist': wishlist?.map((item) => item.toJson()).toList(),
    };
  }
}
