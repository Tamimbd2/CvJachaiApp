import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/my_jobs_controller.dart';

class MyJobsView extends GetView<MyJobsController> {
  const MyJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Posted Jobs',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF38BDF8)),
          );
        }

        if (controller.jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_off_outlined, size: 80, color: Colors.grey[700]),
                const SizedBox(height: 16),
                Text(
                  'No jobs created yet',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchMyJobs,
          color: const Color(0xFF38BDF8),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.jobs.length,
            itemBuilder: (context, index) {
              final job = controller.jobs[index];
              return _buildJobCard(job);
            },
          ),
        );
      }),
    );
  }

  Widget _buildJobCard(dynamic job) {
    return GestureDetector(
      onTap: () => _showApplicantsBottomSheet(job),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['title'] ?? 'No Title',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job['company_name'] ?? 'Company',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF38BDF8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (job['is_active'] ?? true) 
                      ? Colors.green.withValues(alpha: 0.1) 
                      : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    (job['is_active'] ?? true) ? 'Active' : 'Inactive',
                    style: GoogleFonts.inter(
                      color: (job['is_active'] ?? true) ? Colors.greenAccent : Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.grey[400], size: 16),
                const SizedBox(width: 4),
                Text(
                  job['location'] ?? 'Remote',
                  style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
                ),
                const SizedBox(width: 16),
                Icon(Icons.history_rounded, color: Colors.grey[400], size: 16),
                const SizedBox(width: 4),
                Text(
                  '${job['min_experience'] ?? 0} Years Exp',
                  style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              job['description'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (job['skills_required'] as String? ?? '')
                        .split(',')
                        .map((skill) => _buildSkillTag(skill.trim()))
                        .toList(),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.deleteJob(job['id']),
                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 22),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showApplicantsBottomSheet(dynamic job) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF0F172A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Applicants',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        job['title'] ?? '',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF38BDF8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: controller.fetchApplications(job['id']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF38BDF8)));
                  }
                  
                  final applicants = snapshot.data ?? [];
                  
                  if (applicants.isEmpty) {
                    return Center(
                      child: Text(
                        'No applicants yet',
                        style: GoogleFonts.inter(color: Colors.grey[600]),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: applicants.length,
                    itemBuilder: (context, index) {
                      final app = applicants[index];
                      return _buildApplicantCard(app);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildApplicantCard(dynamic app) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF38BDF8).withValues(alpha: 0.1),
            child: Text(
              (app['candidate_name'] as String? ?? 'A')[0].toUpperCase(),
              style: const TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app['candidate_name'] ?? 'Anonymous',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  app['candidate_email'] ?? '',
                  style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          if (app['resume_file'] != null)
            IconButton(
              onPressed: () async {
                String resumeUrl = app['resume_file'];
                if (!resumeUrl.startsWith('http')) {
                  resumeUrl = 'https://cvjachai-api.onrender.com$resumeUrl';
                }
                final Uri url = Uri.parse(resumeUrl);
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  Get.snackbar('Error', 'Could not open resume URL');
                }
              },
              icon: const Icon(Icons.description_outlined, color: Color(0xFFA855F7)),
              tooltip: 'View Resume',
            ),
        ],
      ),
    );
  }

  Widget _buildSkillTag(String skill) {
    if (skill.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        skill,
        style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 11),
      ),
    );
  }
}
