import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

class ApiService extends getx.GetxService {
  late Dio _dio;
  
  static const String baseUrl = 'https://cvjachai-api.onrender.com/api';

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
