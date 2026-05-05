import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cvshortlisting_controller.dart';

class CvshortlistingView extends GetView<CvshortlistingController> {
  const CvshortlistingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resume',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF38BDF8), Color(0xFF9D4EDD)],
                ).createShader(bounds),
                child: Text(
                  'Shortlisting',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Upload resumes and provide job details to find the best matching candidates using AI.',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              
              _buildFormCard(),
              
              const SizedBox(height: 30),
              Obx(() => controller.resultData.value != null 
                  ? _buildResultsSection() 
                  : const SizedBox()),
              
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildTextField(
            'Job Circular / Description',
            'Paste the full job description here...',
            Icons.description_outlined,
            controller: controller.jobCircularController,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          
          _buildFilePicker(),
          
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'Top K',
                  '3',
                  Icons.leaderboard_outlined,
                  controller: controller.topKController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  'Min Exp.',
                  '2',
                  Icons.history_toggle_off_outlined,
                  controller: controller.minExpController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTextField(
            'Skills (Comma separated)',
            'React, Python, HTML...',
            Icons.psychology_outlined,
            controller: controller.skillsController,
          ),
          const SizedBox(height: 32),
          
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.cloud_upload_outlined, color: Color(0xFF38BDF8), size: 18),
            const SizedBox(width: 8),
            Text(
              'Resume Files (ZIP/PDF/DOCX)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() => GestureDetector(
          onTap: controller.pickFiles,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: controller.selectedFiles.isNotEmpty 
                    ? Colors.cyan.withValues(alpha: 0.5) 
                    : Colors.white10,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  controller.selectedFiles.isNotEmpty 
                      ? Icons.check_circle 
                      : Icons.file_present_outlined,
                  color: controller.selectedFiles.isNotEmpty 
                      ? Colors.cyan 
                      : Colors.grey[500],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    controller.selectedFiles.isNotEmpty
                        ? '${controller.selectedFiles.length} file(s) selected'
                        : 'Choose Files or ZIP',
                    style: GoogleFonts.inter(
                      color: controller.selectedFiles.isNotEmpty 
                          ? Colors.white 
                          : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() => Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D2FF).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : () => controller.classifyResumes(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: controller.isLoading.value
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Shortlist Resumes',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    ));
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Candidates',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // This part depends on the exact structure of your API response
        // For now, I'll show a simple list or the raw JSON formatted if it's complex
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(
            controller.resultData.value.toString(),
            style: GoogleFonts.firaCode(color: Colors.cyan[100], fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    IconData icon, {
    int maxLines = 1,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF38BDF8), size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF0F172A).withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF38BDF8),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
