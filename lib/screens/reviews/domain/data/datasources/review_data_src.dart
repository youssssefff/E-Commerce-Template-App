import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/error/exceptions.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/utils/constants.dart';

abstract class ReviewRemoteDataSrc {
  /// Leave a review for a specific product.
  Future<Review> leaveReview(String productId, String userId, int rating, String? content);

  /// Fetch reviews for a specific product.
  Future<List<Review>> getProductReviews(String productId);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSrc {
  final http.Client client;
  final String baseUrl;

  ReviewRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<Review> leaveReview(String productId, String userId, int rating, String? content) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/reviews'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'productId': productId,
          'userId': userId,
          'rating': rating,
          'content': content,
        }),
      );

      if (response.statusCode != 201) {
        throw ServerException(
          message: 'Error while leaving review',
          statusCode: response.statusCode,
        );
      }

      final payload = jsonDecode(response.body);
      return Review.fromJson(payload); // Assuming you have a fromJson method in your Review model

    } on ServerException {
      rethrow;
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
  Future<List<Review>> getProductReviews(String productId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/products/$productId/reviews?page='),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: 'Error while fetching product reviews',
          statusCode: response.statusCode,
        );
      }

      final List<dynamic> payload = jsonDecode(response.body);
      return payload.map((review) => Review.fromJson(review)).toList(); // Assuming you have a fromJson method

    } on ServerException {
      rethrow;
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
