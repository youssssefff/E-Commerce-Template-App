// lib/models/user.dart

import 'package:shop/common/models/address.dart';
import 'package:shop/common/models/user.dart';
import 'package:shop/common/models/wishlist.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required Address address,
    //required List<WishlistProduct> wishlist,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phoneNumber: phoneNumber,
    address: address,
    //wishlist: wishlist,
  );

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address?.toJson(),
    'wishlist': wishlist?.map((product) => product.toJson()).toList(),
  };

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'].toString(),
    firstName: json['firstName'].toString(),
    lastName: json['lastName'].toString(),
    email: json['email'].toString(),
    phoneNumber: json['phoneNumber'].toString(),
    address: Address(
        street :json['street'].toString(),
        apartment:json['apartment'].toString(),
         city:json['city'].toString(),
         country:json['country'].toString(),
        postalCode:json['postalCode'].toString(),
    ),
    //wishlist: List<WishlistProduct>.from(
    //    json['wishlist'].map((item) => WishlistProduct.fromJson(item))),
  );

  // Convert UserModel to Map
  Map<String, dynamic> toMap() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address?.toMap(),
    'wishlist': wishlist?.map((product) => product.toMap()).toList(),
  };

  // Convert Map to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    email: map['email'],
    phoneNumber: map['phoneNumber'],
    address: Address.fromMap(map['address']),
    //wishlist: List<WishlistProduct>.from(
     //   map['wishlist'].map((item) => WishlistProduct.fromMap(item))),
  );

  // copyWith method for UserModel
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    Address? address,
    List<WishlistProduct>? wishlist,
  }) {
    return UserModel(
      id: id ?? this.id!,
      firstName: firstName ?? this.firstName!,
      lastName: lastName ?? this.lastName!,
      email: email ?? this.email!,
      phoneNumber: phoneNumber ?? this.phoneNumber!,
      address: address ?? this.address!,
      //wishlist: wishlist ?? this.wishlist!,
    );
  }
}
