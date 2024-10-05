import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/common/models/product.dart';
import 'package:shop/error/exceptions.dart';

abstract class ProductRemoteDataSrc {
  /// Fetch a list of products with optional search, sorting, and pagination.
  Future<List<Product>> getProducts({
    required int page,
    required int pageSize,
    String search,
    String sortBy,
    String sortOrder,
    String criteria,
  });

  /// Search for products based on search terms and optional filters.
  Future<List<Product>> searchProducts({
    required String searchTerms,
    required int page,
    String? category,
    String? genderAgeCategory,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSrc {
  final http.Client client;
  final String baseUrl;

  ProductRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<Product>> getProducts({
    required int page,
    required int pageSize,
    String search = '',
    String sortBy = 'createdAt',
    String sortOrder = 'ASC',
    String criteria = '',
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/products?page=$page&pageSize=$pageSize&search=$search&sortBy=$sortBy&sortOrder=$sortOrder&criteria=$criteria'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: "Error fetching products",
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> payload = jsonDecode(response.body);
      return payload.map((json) => Product.fromJson(json)).toList();
    } on ServerException {
      rethrow;
    }catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<Product>> searchProducts({
    required String searchTerms,
    required int page,
    String? category,
    String? genderAgeCategory,
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/products/search?page=$page&searchTerms=$searchTerms&category=${category ?? ''}&genderAgeCategory=${genderAgeCategory ?? ''}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: "Error searching for products",
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> payload = jsonDecode(response.body);
      return payload.map((json) => Product.fromJson(json)).toList();
    } on ServerException {
      rethrow;
    }catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
