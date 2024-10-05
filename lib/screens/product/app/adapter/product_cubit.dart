import 'package:bloc/bloc.dart';
import 'package:shop/screens/product/app/adapter/product_state.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required GetProducts getProducts,
    required SearchProducts searchProducts,
  })  : _getProducts = getProducts,
        _searchProducts = searchProducts,
        super(const ProductInitial());

  final GetProducts _getProducts;
  final SearchProducts _searchProducts;

  // Fetch products with pagination and sorting
  Future<void> getProducts({
    required int page,
    required int pageSize,
    String search = '',
    String sortBy = 'createdAt',
    String sortOrder = 'ASC',
    String criteria = '',
  }) async {
    emit(const GetProductsLoading()); // Emit loading state

    // Create GetProductsParams instance
    final params = GetProductsParams(
      page: page,
      pageSize: pageSize,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
      criteria: criteria,
    );

    final result = await _getProducts(params); // Pass params

    result.fold(
          (failure) => emit(ProductError(failure)), // Emit error state
          (products) => emit(GetProductsSuccess(products)), // Emit success state
    );
  }

  // Search products by terms
  Future<void> searchProducts({
    required String searchTerms,
    required int page,
    String? category,
    String? genderAgeCategory,
  }) async {
    emit(const SearchProductsLoading()); // Emit loading state

    // Create SearchProductsParams instance
    final params = SearchProductsParams(
      searchTerms: searchTerms,
      page: page,
      category: category,
      genderAgeCategory: genderAgeCategory,
    );

    final result = await _searchProducts(params); // Pass params

    result.fold(
          (failure) => emit(ProductError(failure)), // Emit error state
          (products) => emit(SearchProductsSuccess(products)), // Emit success state
    );
  }
}
