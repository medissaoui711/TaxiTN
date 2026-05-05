import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';

@singleton
class ApiClient {
  late final Dio _dio;
  final Logger _logger = Logger();
  String? _authToken;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseApiUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
          
          // Add auth token if available
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          _logger.e(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
            error: error.message,
          );
          return handler.next(error);
        },
      ),
    );
  }

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkException('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['error'] ?? 'Unknown error';
        
        if (statusCode == 401) {
          return UnauthorizedException(message);
        } else if (statusCode == 404) {
          return NotFoundException(message);
        } else if (statusCode == 500) {
          return ServerException(message);
        }
        return ApiException(message, statusCode: statusCode);
      default:
        return ApiException(error.message ?? 'Unknown error');
    }
  }
}
