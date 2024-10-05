import 'package:flutter/cupertino.dart';
import 'package:shop/common/models/order.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/error/exceptions.dart';
import 'package:shop/utils/constants.dart'; // Assuming this contains your API base URL

abstract class OrderRemoteDataSrc {
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> getOrderById(String orderId);
}

class OrderRemoteDataSrcImpl implements OrderRemoteDataSrc {
  final http.Client client;

  OrderRemoteDataSrcImpl({required this.client});

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/orders?userId=$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((orderJson) => OrderModel.fromJson(orderJson)).toList();
      }
      else{
        throw ServerException(
          message: "smth went wrong",
          statusCode: 500,
        );
      }

    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/orders/$orderId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return OrderModel.fromJson(data);
      }else{
        throw ServerException(
          message: "smth went wrong",
          statusCode: 500,
        );}

    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
