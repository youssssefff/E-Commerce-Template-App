import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/reviews/domain/data/datasources/review_data_src.dart';
import 'package:shop/screens/reviews/domain/repos/review_repo.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSrc remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Review>> leaveReview({
    required String productId,
    required String userId,
    required int rating,
    String? content,
  }) async {
    try {
      final review = await remoteDataSource.leaveReview(
        productId,
        userId,
        rating,
        content
      );
      return Right(review);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }

  @override
  Future<Either<Failure, List<Review>>> getProductReviews(String productId) async {
    try {
      final reviews = await remoteDataSource.getProductReviews(productId);
      return Right(reviews);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );}
  }
}
