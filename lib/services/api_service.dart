import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:task_app/constants/app_constant.dart';
import 'package:task_app/constants/slogans.dart';

class ApiService {
  static final Dio _dio = Dio();

  static final ApiService instance = ApiService._internal();
  factory ApiService() => instance;
  ApiService._internal();

  Future<Response> fetchProduct() async {
    final Map<String, dynamic> parameters = {'limit': 40, 'skip': 0};

    final response = await _makeApiCall(
      path: '${AppConstant.task1Api}/products',
      parameters: parameters,
    );
    return response;
  }

  Future<Response> fetchTask2Product() async {
    final response = await _makeApiCall(
      path: '${AppConstant.task2Api}/products',
    );
    return response;
  }

  Future<Response> _makeApiCall({
    String path = '',
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _dio.request(path, queryParameters: parameters);
      log('api-res: $response');
      log('api-status-code: ${response.statusCode}');

      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    log('api-error: ${e.message}');
    switch (e.type) {
      case DioExceptionType.connectionError:
        return Slogans.noInternet;
      case DioExceptionType.receiveTimeout:
        return Slogans.timeout;
      default:
        return Slogans.somethingWentWrong;
    }
  }
}
