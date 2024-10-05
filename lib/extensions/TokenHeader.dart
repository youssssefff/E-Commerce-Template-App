import 'package:shop/common/app/cache_helper.dart';

extension TokenHeader on CacheHelper {
  Future<Map<String, String>> getAuthHeader() async {
    // Retrieve the cached session token
    final String? token = await this.getSessionToken();

    // Return the Authorization header map if the token exists
    if (token != null && token.isNotEmpty) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    } else {
      // In case the token doesn't exist or is empty, return just the Content-Type header
      return {
        'Content-Type': 'application/json',
      };
    }
  }
}
