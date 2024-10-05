import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/cart.dart';
import 'package:shop/common/models/cart_product.dart';
import 'package:shop/error/exceptions.dart';

abstract class CartRemoteDataSource {
  /// Fetch the cart for a user by their ID.
  Future<Cart> getCart(String userId);

  /// Fetch the cart count for a user.
  Future<Cart> getUserCartCount(String userId);

  /// Add a product to the cart for the given user.
  Future<Cart> addToCart(String userId, CartProduct product);

  /// Remove a product from the cart.
  Future<Cart> removeFromCart(String userId, String productId);

  /// Update the cart with a new product or modifications.
  Future<Cart> updateCart(String userId, CartProduct product);

  /// Modify the quantity of a product in the cart.
  Future<Cart> modifyProductQuantity(String userId, String productId, int newQuantity);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  CartRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<Cart> getCart(String userId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cart/$userId'));

      if (response.statusCode != 200) {
        throw ServerException(
          message: "Error while fetching the cart",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<Cart> getUserCartCount(String userId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cart/$userId/count'));

      if (response.statusCode != 200) {
        throw ServerException(
          message: "Error while fetching cart count",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<Cart> addToCart(String userId, CartProduct product) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/cart/$userId/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          message: "Error while adding product to cart",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<Cart> removeFromCart(String userId, String productId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/cart/$userId/remove/$productId'),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: "Error while removing product from cart",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<Cart> updateCart(String userId, CartProduct product) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/cart/$userId/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          message: "Error while updating cart",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<Cart> modifyProductQuantity(String userId, String productId, int newQuantity) async {
    try {
      final response = await client.patch(
        Uri.parse('$baseUrl/cart/$userId/quantity/$productId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'quantity': newQuantity}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          message: "Error while modifying product quantity",
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Cart.fromJson(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
