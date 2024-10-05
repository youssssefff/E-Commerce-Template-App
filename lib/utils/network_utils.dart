import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/common/app/cache_helper.dart';
import 'package:shop/route/route_constants.dart';
import '../services/injection_container/main.dart';

abstract class NetworkUtils {
  const NetworkUtils();

  static Future<void> renewToken(http.Response response, BuildContext context) async {
    // Check if the authorization header is present
    final authHeader = response.headers['authorization'];
    if (authHeader != null) {
      // Extract the token
      var token = authHeader.trim();
      if (token.startsWith('Bearer ')) {
        token = token.replaceFirst('Bearer ', '').trim();
        // Cache the token
        await sl<CacheHelper>().cacheSessionToken(token);
      }
    }
    // Handle unauthorized access
    else if (response.statusCode == 401) {
      // Navigate to the root route or login screen
      Navigator.pushNamed(context, rootRoute);
    }
  }
}
