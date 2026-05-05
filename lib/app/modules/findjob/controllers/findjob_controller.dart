import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../data/models/job_model.dart';
import '../../../data/services/api_service.dart';

class FindjobController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final expandedIndex = (-1).obs; // Start with nothing expanded since data is dynamic
  final isLoading = false.obs;
  final jobs = <Job>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  Future<void> fetchJobs() async {
    try {
      isLoading.value = true;
      final response = await _apiService.get('/jobs/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        jobs.value = data.map((json) => Job.fromJson(json)).toList();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch jobs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}


