// domain/repos/product_repo.dart
import 'package:dartz/dartz.dart';
import 'package:shop/common/models/product.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/utils/constants.dart';

abstract class ProductRepository {
  ResultFuture<List<Product>> getProducts({
    required int page,
    required int pageSize,
    String search,
    String sortBy,
    String sortOrder,
    String criteria,
  });
  ResultFuture<List<Product>> searchProducts({
    required String searchTerms,
    required int page,
    String? category,
    String? genderAgeCategory,
  });
}
