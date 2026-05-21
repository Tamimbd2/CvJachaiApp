import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import '../../../data/services/api_service.dart';

class CvshortlistingController extends GetxController {
  final _apiService = Get.find<ApiService>();
  final _box = GetStorage();

  final jobCircularController = TextEditingController();
  final topKController = TextEditingController(text: '3');
  final skillsController = TextEditingController();
  final minExpController = TextEditingController();

  final selectedFiles = <File>[].obs;
  final isLoading = false.obs;
  final resultData = Rx<dynamic>(null);

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'zip'],
    );

    if (result != null) {
      selectedFiles.value = result.paths.map((path) => File(path!)).toList();
    }
  }

  Future<void> classifyResumes() async {
    if (selectedFiles.isEmpty) {
      Get.snackbar('Error', 'Please select at least one resume file or a zip.');
      return;
    }
    if (jobCircularController.text.isEmpty) {
      Get.snackbar('Error', 'Please provide the job description.');
      return;
    }

    try {
      isLoading.value = true;

      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];

      if (token == null) {
        Get.snackbar('Error', 'Session expired. Please login again.');
        return;
      }

      List<dio.MultipartFile> multipartFiles = [];
      for (var file in selectedFiles) {
        String fileName = file.path.split(RegExp(r'[/\\]')).last;
        multipartFiles.add(await dio.MultipartFile.fromFile(file.path, filename: fileName));
      }

      dio.FormData data = dio.FormData.fromMap({
        'resume_files': multipartFiles.length == 1 ? multipartFiles.first : multipartFiles,
        'job_circular': jobCircularController.text.trim(),
        'top_k': topKController.text.trim().isEmpty ? '5' : topKController.text.trim(),
        'skills': skillsController.text.trim(),
        'min_experience': minExpController.text.trim().isEmpty ? '0' : minExpController.text.trim(),
      });

      var response = await _apiService.post(
        '/classify',
        data: data,
        options: dio.Options(
          contentType: 'multipart/form-data',
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        resultData.value = response.data;
        Get.snackbar(
          'Success',
          'Resumes classified successfully!',
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Classification failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    jobCircularController.dispose();
    topKController.dispose();
    skillsController.dispose();
    minExpController.dispose();
    super.onClose();
  }
}

