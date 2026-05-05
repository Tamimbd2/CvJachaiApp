import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/services/api_service.dart';

class MyJobsController extends GetxController {
  final _apiService = Get.find<ApiService>();
  final _box = GetStorage();

  final jobs = <dynamic>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyJobs();
  }

  Future<void> fetchMyJobs() async {
    try {
      isLoading.value = true;
      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];

      if (token == null) {
        Get.snackbar('Error', 'Session expired. Please login again.');
        return;
      }

      var response = await _apiService.get(
        '/jobs/my/',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        jobs.value = response.data;
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Failed to fetch jobs');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];

      if (token == null) return;

      Get.dialog(
        AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Job', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to delete this job posting?',
              style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                var response = await _apiService.delete(
                  '/jobs/$jobId/delete/',
                  options: dio.Options(
                    headers: {
                      'Authorization': 'Bearer $token',
                    },
                  ),
                );

                if (response.statusCode == 200 || response.statusCode == 204) {
                  Get.snackbar('Success', 'Job deleted successfully');
                  fetchMyJobs();
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete job: $e');
    }
  }
}
