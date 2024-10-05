import 'package:shop/common/models/product.dart';
import 'package:shop/screens/product/domain/repos/product_repo.dart';
import 'package:shop/usecase/usecase.dart';
import 'package:shop/utils/constants.dart';

class GetProductsParams {
  final int page;
  final int pageSize;
  final String search;
  final String sortBy;
  final String sortOrder;
  final String criteria;

  GetProductsParams({
    required this.page,
    required this.pageSize,
    this.search = '',
    this.sortBy = 'createdAt',
    this.sortOrder = 'ASC',
    this.criteria = '',
  });
}

class GetProducts extends UseCaseWithParams<List<Product>, GetProductsParams> {
  final ProductRepository _repository;

  GetProducts(this._repository);

  @override
  ResultFuture<List<Product>> call(GetProductsParams params) async {
    return await _repository.getProducts(
      page: params.page,
      pageSize: params.pageSize,
      search: params.search,
      sortBy: params.sortBy,
      sortOrder: params.sortOrder,
      criteria: params.criteria,
    );
  }
}