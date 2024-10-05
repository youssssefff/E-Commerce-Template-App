// lib/core/exceptions.dart

// Base exception class
class AppException implements Exception {
  final String message;
  AppException(this.message);
}

// Specific exceptions
class CacheException extends AppException {
  CacheException(String message) : super(message);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

// lib/error/exceptions.dart

class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException({
    required this.message,
    this.statusCode = 500, // Default to 500 if not provided
  });

  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode)';
}


class AuthenticationException extends AppException {
  AuthenticationException(String message) : super(message);
}
