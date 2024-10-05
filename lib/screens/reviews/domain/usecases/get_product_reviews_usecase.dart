import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/screens/reviews/domain/repos/review_repo.dart';
import 'package:shop/usecase/usecase.dart';

class GetProductReviews extends UseCaseWithParams<List<Review>, GetProductReviewsParams> {
  final ReviewRepository _repository;

  GetProductReviews(this._repository);

  @override
  Future<Either<Failure, List<Review>>> call(GetProductReviewsParams params) async {
    return await _repository.getProductReviews(params.productId);
  }
}

class GetProductReviewsParams {
  final String productId;
  final int page;

  GetProductReviewsParams({
    required this.productId,
    this.page = 1, // Default page number is 1
  });
}
