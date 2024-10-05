// data/repos/product_repo_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/product.dart';
import 'package:shop/error/exceptions.dart';
import 'package:shop/error/failure.dart';
import 'package:shop/screens/product/domain/data/datasources/product_remote_data_src.dart';
import 'package:shop/screens/product/domain/repos/product_repo.dart';
import 'package:shop/utils/constants.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSrc remoteDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  ResultFuture<List<Product>> getProducts({
    required int page,
    required int pageSize,
    String search = '',
    String sortBy = 'createdAt',
    String sortOrder = 'ASC',
    String criteria = '',
  }) async {
    try {
      // Fetch products from the remote data source
      final List<Product> products = await remoteDataSource.getProducts(
        page: page,
        pageSize: pageSize,
        search: search,
        sortBy: sortBy,
        sortOrder: sortOrder,
        criteria: criteria,
      );
      return Right(products);
    } catch (e, s) {
      // Log the error and throw a custom server exception
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  ResultFuture<List<Product>> searchProducts({
    required String searchTerms,
    required int page,
    String? category,
    String? genderAgeCategory,
  }) async {
    try {
      // Fetch products based on the search criteria
      final List<Product> products = await remoteDataSource.searchProducts(
        searchTerms: searchTerms,
        page: page,
        category: category,
        genderAgeCategory: genderAgeCategory,
      );
      return Right(products);
    } catch (e, s) {
      // Log the error and throw a custom server exception
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
