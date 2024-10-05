import 'package:shop/common/models/product.dart';
import 'package:shop/screens/product/domain/repos/product_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class SearchProductsParams {
  final String searchTerms;
  final int page;
  final String? category;
  final String? genderAgeCategory;

  SearchProductsParams({
    required this.searchTerms,
    required this.page,
    this.category,
    this.genderAgeCategory,
  });
}

class SearchProducts extends UseCaseWithParams<List<Product>, SearchProductsParams> {
  final ProductRepository _repository;

  SearchProducts(this._repository);

  @override
  ResultFuture<List<Product>> call(SearchProductsParams params) async {
    return await _repository.searchProducts(
      searchTerms: params.searchTerms,
      page: params.page,
      category: params.category,
      genderAgeCategory: params.genderAgeCategory,
    );
  }
}
