import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';

class ApiService extends getx.GetxService {
  late Dio _dio;
  
  static const String rootUrl = 'https://cvjachai.online';
  static const String baseUrl = '$rootUrl/api';

  Future<ApiService> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for error logging only
    _dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
      error: true,
    ));

    // Handle global 401 Unauthorized errors (excluding auth endpoints)
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          final path = e.requestOptions.path;
          if (!path.contains('/auth/')) {
            final box = GetStorage();
            box.remove('is_logged_in');
            box.remove('user_data');

            if (getx.Get.currentRoute != '/login') {
              getx.Get.offAllNamed('/login');
              getx.Get.snackbar(
                'Session Expired',
                'Your session has expired. Please login again.',
                snackPosition: getx.SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.1),
                colorText: Colors.white,
              );
            }
          }
        }
        return handler.next(e);
      },
    ));

    return this;
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await _dio.delete(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Add other methods like put as needed
}
