import 'package:dartz/dartz.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/error/failure.dart';

abstract class ReviewRepository {
  Future<Either<Failure, Review>> leaveReview({
    required String productId,
    required String userId,
    required int rating,
    String? content,
  });

  Future<Either<Failure, List<Review>>> getProductReviews(String productId);
}
