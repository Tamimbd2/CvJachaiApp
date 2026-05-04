import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../routes/app_pages.dart';
import '../../../data/services/api_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final isLoading = false.obs;
  final _apiService = Get.find<ApiService>();

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
