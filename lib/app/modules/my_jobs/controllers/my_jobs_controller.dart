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
        // Handle both paginated responses ({"results": [...]}) and plain lists
        final data = response.data;
        if (data is List) {
          jobs.value = data;
        } else if (data is Map && data.containsKey('results')) {
          jobs.value = data['results'] as List<dynamic>;
        } else {
          jobs.value = [];
          Get.snackbar('Error', 'Unexpected response format from server.');
        }
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Failed to fetch jobs');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Accepts dynamic [jobId] so it works whether the API returns int or String ids.
  Future<void> deleteJob(dynamic jobId) async {
    try {
      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];

      if (token == null) {
        Get.snackbar('Error', 'Session expired. Please login again.');
        return;
      }

      // Convert to string for safe URL interpolation
      final String jobIdStr = jobId.toString();

      Get.dialog(
        AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Job', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to delete this job posting?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); // Close dialog first
                try {
                  var response = await _apiService.delete(
                    '/jobs/$jobIdStr/delete/',
                    options: dio.Options(
                      headers: {
                        'Authorization': 'Bearer $token',
                      },
                    ),
                  );

                  if (response.statusCode == 200 || response.statusCode == 204) {
                    Get.snackbar(
                      'Success',
                      'Job deleted successfully',
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                      colorText: Colors.greenAccent,
                    );
                    fetchMyJobs();
                  } else {
                    Get.snackbar(
                      'Error',
                      response.statusMessage ?? 'Failed to delete job',
                    );
                  }
                } catch (e) {
                  Get.snackbar('Error', 'Failed to delete job: $e');
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

  /// Accepts dynamic [jobId] so it works whether the API returns int or String ids.
  Future<List<dynamic>> fetchApplications(dynamic jobId) async {
    try {
      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];
      if (token == null) return [];

      final String jobIdStr = jobId.toString();

      var response = await _apiService.get(
        '/jobs/$jobIdStr/applications/',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) return data;
        if (data is Map && data.containsKey('results')) {
          return data['results'] as List<dynamic>;
        }
      }
    } catch (e) {
      debugPrint('Error fetching applications: $e');
      Get.snackbar('Error', 'Could not load applicants. Please try again.');
    }
    return [];
  }
}
