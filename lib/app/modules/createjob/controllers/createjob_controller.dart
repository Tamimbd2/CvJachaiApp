import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/services/api_service.dart';

class CreatejobController extends GetxController {
  final _apiService = Get.find<ApiService>();
  final _box = GetStorage();

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final locationController = TextEditingController();
  final expController = TextEditingController();
  final skillsController = TextEditingController();
  final descController = TextEditingController();

  final isLoading = false.obs;

  Future<void> postJob() async {
    if (titleController.text.isEmpty ||
        companyController.text.isEmpty ||
        locationController.text.isEmpty ||
        expController.text.isEmpty ||
        skillsController.text.isEmpty ||
        descController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token']; // Common JWT keys

      if (token == null) {
        Get.snackbar('Error', 'Session expired. Please login again.');
        return;
      }

      var data = {
        "title": titleController.text.trim(),
        "description": descController.text.trim(),
        "skills_required": skillsController.text.trim(),
        "min_experience": int.tryParse(expController.text.trim()) ?? 0,
        "company_name": companyController.text.trim(),
        "location": locationController.text.trim(),
      };

      var response = await _apiService.post(
        '/jobs/',
        data: data,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          'Success',
          'Job posted successfully!',
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Failed to post job');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    companyController.dispose();
    locationController.dispose();
    expController.dispose();
    skillsController.dispose();
    descController.dispose();
    super.onClose();
  }
}

