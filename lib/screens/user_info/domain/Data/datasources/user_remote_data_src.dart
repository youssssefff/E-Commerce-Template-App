import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/error/exceptions.dart';
import 'package:shop/screens/auth/domain/data/models/user_model.dart';
import 'package:shop/utils/constants.dart';

abstract class UserRemoteDataSrc {
  /// Fetch a user by their ID from the remote source.
  Future<UserModel> getUser(String userId);

  /// Update user data with the provided `updatedData`.
  Future<UserModel> updateUser(String userId, DataMap updatedData);

  /// Fetch the payment profile ID associated with the user.
  Future<String> getUserPaymentProfile(String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSrc {
  final http.Client client;
  final String baseUrl;

  UserRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$userId'),
        //headers: Cache.instance.sessionToken!.toAuthHeaders,
      );
      final payload = jsonDecode(response.body);
      //await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        throw ServerException(
          message: "error while fetching user",
          statusCode: response.statusCode
        );
      }
      return UserModel.fromJson(payload);
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
  Future<UserModel> updateUser(String userId, DataMap updatedData) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/$userId'),
        //headers: Cache.instance.sessionToken!.toAuthHeaders,
        body: jsonEncode(updatedData),
      );

      final payload = jsonDecode(response.body);
      //await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
            message: "error while updating user",
            statusCode: response.statusCode
        );
      }
      return UserModel.fromJson(payload);
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
  Future<String> getUserPaymentProfile(String userId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$userId/payment_profile'),
        headers: {'Content-Type': 'application/json'},
      );

      final payload = jsonDecode(response.body);
      //await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
            message: "error while updating user",
            statusCode: response.statusCode
        );
      }
      return payload['url'] as String;

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
