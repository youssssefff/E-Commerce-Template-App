import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop/common/models/review.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/reviews/domain/repos/review_repo.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewCubit(this.reviewRepository) : super(ReviewInitial());

  Future<void> fetchProductReviews(String productId) async {
    emit(ReviewLoading());
    final result = await reviewRepository.getProductReviews(productId);
    result.fold(
          (failure) {
        emit(ReviewError(failure.message)); // Assuming Failure has a message property
      },
          (reviews) {
        emit(ReviewLoaded(reviews));
      },
    );
  }

  Future<void> leaveProductReview({
    required String productId,
    required String userId,
    required int rating,
    String? content,
  }) async {
    emit(ReviewLoading());
    final result = await reviewRepository.leaveReview(
      productId: productId,
      userId: userId,
      rating: rating,
      content: content,
    );

    result.fold(
          (failure) {
        emit(ReviewError(failure.message)); // Assuming Failure has a message property
      },
          (review) {
        // Optionally, you might want to fetch the reviews again after leaving a new one
        fetchProductReviews(productId);
      },
    );
  }
}
