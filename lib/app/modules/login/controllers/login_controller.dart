import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';
import '../../../data/services/api_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final isLoading = false.obs;
  final isRememberMe = false.obs;
  final _apiService = Get.find<ApiService>();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    final savedEmail = _box.read('email');
    final savedPassword = _box.read('password');
    final rememberMe = _box.read('remember_me') ?? false;

    if (rememberMe) {
      emailController.text = savedEmail ?? '';
      passwordController.text = savedPassword ?? '';
      isRememberMe.value = true;
    }
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    try {
      isLoading.value = true;
      
      var data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      };

      var response = await _apiService.post(
        '/auth/signin',
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint(json.encode(response.data));
        
        if (isRememberMe.value) {
          _box.write('email', emailController.text.trim());
          _box.write('password', passwordController.text.trim());
          _box.write('remember_me', true);
        } else {
          _box.remove('email');
          _box.remove('password');
          _box.write('remember_me', false);
        }

        // Save session
        _box.write('is_logged_in', true);
        _box.write('user_data', response.data);

        Get.snackbar('Success', 'Login successful');
        Get.offAllNamed(Routes.navbar);
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Login failed');
      }
    } on DioException catch (e) {
      String errorMessage = 'Something went wrong';
      if (e.response != null) {
        errorMessage = e.response?.data['detail'] ?? e.response?.statusMessage ?? errorMessage;
      }
      Get.snackbar('Error', errorMessage);
      debugPrint(e.toString());
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
