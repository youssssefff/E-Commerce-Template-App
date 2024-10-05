import 'package:dartz/dartz.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/screens/reviews/domain/repos/review_repo.dart';
import 'package:shop/usecase/usecase.dart';

class LeaveReview extends UseCaseWithParams<Review, LeaveReviewParams> {
  final ReviewRepository _repository;

  LeaveReview(this._repository);

  @override
  Future<Either<Failure, Review>> call(LeaveReviewParams params) async {
    return await _repository.leaveReview(
      productId: params.productId,
      userId: params.userId,
      rating: params.rating,
      content: params.content,
    );
  }
}

class LeaveReviewParams {
  final String productId;
  final String userId;
  final int rating;
  final String? content;

  LeaveReviewParams({
    required this.productId,
    required this.userId,
    required this.rating,
    this.content,
  });
}
