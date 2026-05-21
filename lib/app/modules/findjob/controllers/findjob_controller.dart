import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/job_model.dart';
import '../../../data/services/api_service.dart';

class FindjobController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final expandedIndex = (-1).obs;
  final isLoading = false.obs;
  final jobs = <Job>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void toggleExpanded(int index) {
    expandedIndex.value = (expandedIndex.value == index) ? -1 : index;
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.get('/jobs/');

      if (response.statusCode == 200) {
        final data = response.data;

        List<dynamic> jobList;
        // Handle paginated responses e.g. {"results": [...], "count": N}
        if (data is List) {
          jobList = data;
        } else if (data is Map && data.containsKey('results')) {
          jobList = data['results'] as List<dynamic>;
        } else {
          jobList = [];
        }

        jobs.value = jobList.map((json) => Job.fromJson(json)).toList();
      } else {
        errorMessage.value = 'Server returned ${response.statusCode}. Please try again.';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      // Provide specific, user-friendly messages per error type
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        errorMessage.value = 'Connection timed out. Check your internet and try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage.value = 'No internet connection. Please check your network.';
      } else {
        errorMessage.value = 'Failed to load jobs. Please try again.';
      }
      Get.snackbar(
        'Connection Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        mainButton: TextButton(
          onPressed: fetchJobs,
          child: const Text('Retry', style: TextStyle(color: Color(0xFF38BDF8))),
        ),
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
