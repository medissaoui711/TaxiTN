class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error occurred']);
  
  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'Network error occurred']);
  
  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException([this.message = 'Connection timeout']);
  
  @override
  String toString() => 'TimeoutException: $message';
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized']);
  
  @override
  String toString() => 'UnauthorizedException: $message';
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException([this.message = 'Resource not found']);
  
  @override
  String toString() => 'NotFoundException: $message';
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  const ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error occurred']);
  
  @override
  String toString() => 'CacheException: $message';
}
