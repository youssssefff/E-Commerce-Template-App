// lib/core/failure.dart

class Failure {
  final String message;
  final int? statusCode;

  Failure(this.message, [this.statusCode]);
}


class ServerFailure extends Failure {
  ServerFailure(String message, [int? statusCode]) : super(message, statusCode);
}


class NetworkFailure extends Failure {
  NetworkFailure(String message, [int? statusCode]) : super(message, statusCode);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(String message, [int? statusCode]) : super(message, statusCode);
}


class CacheFailure extends Failure {
  CacheFailure(String message, [int? statusCode]) : super(message, statusCode);
}
