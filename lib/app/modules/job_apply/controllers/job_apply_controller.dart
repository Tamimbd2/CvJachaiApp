import 'dart:io';
import 'package:cv_jachai_app/app/data/models/job_model.dart';
import 'package:cv_jachai_app/app/data/services/api_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JobApplyController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final GetStorage _box = GetStorage();

  late Job job;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final selectedFile = Rx<File?>(null);
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    job = Get.arguments as Job;
    _loadUserData();
  }

  void _loadUserData() {
    final userData = _box.read('user_data');
    if (userData != null) {
      // Adjust keys based on your actual API response structure
      nameController.text = userData['name'] ?? '';
      emailController.text = userData['email'] ?? '';
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  Future<void> applyForJob() async {
    if (selectedFile.value == null) {
      Get.snackbar('Error', 'Please select a CV/Resume file');
      return;
    }

    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      String fileName = selectedFile.value!.path.split('/').last;
      
      dio.FormData data = dio.FormData.fromMap({
        'resume_file': await dio.MultipartFile.fromFile(
          selectedFile.value!.path,
          filename: fileName,
        ),
        'job': job.id,
        'candidate_name': nameController.text.trim(),
        'candidate_email': emailController.text.trim(),
      });

      var response = await _apiService.post(
        '/jobs/apply/',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        Get.snackbar(
          'Success',
          'Application submitted successfully!',
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Failed to apply');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
