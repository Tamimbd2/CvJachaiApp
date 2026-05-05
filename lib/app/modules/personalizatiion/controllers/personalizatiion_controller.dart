import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../data/services/api_service.dart';
import '../../../routes/app_pages.dart';


class PersonalizatiionController extends GetxController {
  final _apiService = Get.find<ApiService>();
  final _box = GetStorage();

  final jobDescriptionController = TextEditingController();
  final selectedFile = Rx<File?>(null);
  final isLoading = false.obs;
  final optimizedMarkdown = RxString('');

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  Future<void> optimizeResume() async {
    if (selectedFile.value == null) {
      Get.snackbar('Error', 'Please select a resume file to optimize.');
      return;
    }

    try {
      isLoading.value = true;
      optimizedMarkdown.value = '';

      final userData = _box.read('user_data');
      final token = userData?['access'] ?? userData?['token'];

      if (token == null) {
        Get.snackbar('Error', 'Session expired. Please login again.');
        return;
      }

      String fileName = selectedFile.value!.path.split('/').last;
      dio.FormData data = dio.FormData.fromMap({
        'resume_file': await dio.MultipartFile.fromFile(selectedFile.value!.path, filename: fileName),
        'job_description': jobDescriptionController.text.trim(),
      });

      var response = await _apiService.post(
        '/optimize',
        data: data,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        optimizedMarkdown.value = response.data['optimized_resume_markdown'] ?? '';
        Get.snackbar(
          'Success',
          'Resume optimized successfully!',
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.white,
        );
        // Automatically open PDF after optimization
        generateAndShowPdf();
      } else {
        Get.snackbar('Error', response.statusMessage ?? 'Optimization failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateAndShowPdf() async {
    if (optimizedMarkdown.value.isEmpty) return;

    try {
      final pdf = pw.Document();
      final font = await PdfGoogleFonts.interRegular();
      final fontBold = await PdfGoogleFonts.interBold();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          build: (pw.Context context) {
            bool isFirstLine = true;
            
            return optimizedMarkdown.value.split('\n').map((line) {
              String trimmed = line.trim();
              if (trimmed.isEmpty) return pw.SizedBox(height: 1);

              // Skip references line if requested
              if (trimmed.toLowerCase().contains('references') && trimmed.toLowerCase().contains('request')) {
                return pw.SizedBox();
              }

              // Handle Horizontal Rule
              if (trimmed.startsWith('---')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Divider(thickness: 0.5, color: PdfColors.grey400),
                );
              }

              // Handle Table lines (Category | Tools)
              if (trimmed.startsWith('|') && trimmed.contains('|')) {
                if (trimmed.contains('---')) return pw.SizedBox();
                List<String> cells = trimmed.split('|')
                    .where((c) => c.trim().isNotEmpty)
                    .map((c) => c.trim().replaceAll('**', ''))
                    .toList();
                if (cells.length >= 2) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 2),
                    child: pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: '${cells[0]}: ', style: pw.TextStyle(font: fontBold, fontSize: 9.5)),
                          pw.TextSpan(text: cells[1], style: pw.TextStyle(font: font, fontSize: 9.5)),
                        ],
                      ),
                    ),
                  );
                }
              }

              // Handle Headers
              if (trimmed.startsWith('###')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 4, bottom: 1),
                  child: pw.Text(
                    trimmed.replaceAll('###', '').trim(),
                    style: pw.TextStyle(font: fontBold, fontSize: 11),
                  ),
                );
              } else if (trimmed.startsWith('##')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        trimmed.replaceAll('##', '').trim().toUpperCase(),
                        style: pw.TextStyle(font: fontBold, fontSize: 13, color: PdfColors.blue800),
                      ),
                      pw.Divider(thickness: 0.8, color: PdfColors.blue800),
                    ],
                  ),
                );
              } else if (trimmed.startsWith('#')) {
                isFirstLine = false;
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 2),
                  child: pw.Text(
                    trimmed.replaceAll('#', '').trim(),
                    style: pw.TextStyle(font: fontBold, fontSize: 24, color: PdfColors.black),
                  ),
                );
              }

              // Special Handling for Name
              if (isFirstLine && trimmed.startsWith('**') && trimmed.endsWith('**')) {
                isFirstLine = false;
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 2),
                  child: pw.Text(
                    trimmed.replaceAll('**', '').trim(),
                    style: pw.TextStyle(font: fontBold, fontSize: 24, color: PdfColors.black),
                  ),
                );
              }
              isFirstLine = false;

              // Detect contact info
              if (trimmed.contains('@') || trimmed.contains('Phone:') || trimmed.contains('LinkedIn:') || trimmed.contains('GitHub:') || trimmed.contains('Bangladesh')) {
                String cleanContact = trimmed
                    .replaceAll('**', '')
                    .replaceAll('*', '')
                    .replaceAll('|', ' • ')
                    .trim();
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 1),
                  child: pw.Text(
                    cleanContact,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(font: font, fontSize: 9, color: PdfColors.grey700),
                  ),
                );
              }

              // Handle Bullet Points (Require space after symbol)
              bool isBullet = (trimmed.startsWith('* ') || trimmed.startsWith('- '));
              String cleanLine = trimmed
                  .replaceAll('**', '')
                  .replaceAll('*', '')
                  .replaceAll('-', '')
                  .trim();

              if (cleanLine.isEmpty) return pw.SizedBox();

              bool wasBold = trimmed.contains('**');

              if (isBullet) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 12, bottom: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                        child: pw.Container(
                          width: 3,
                          height: 3,
                          decoration: const pw.BoxDecoration(color: PdfColors.black, shape: pw.BoxShape.circle),
                        ),
                      ),
                      pw.SizedBox(width: 8),
                      pw.Expanded(
                        child: pw.Text(
                          cleanLine,
                          style: pw.TextStyle(
                            font: wasBold ? fontBold : font,
                            fontSize: 10,
                            lineSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Normal Text
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 2),
                child: pw.Text(
                  cleanLine,
                  style: pw.TextStyle(
                    font: wasBold ? fontBold : font,
                    fontSize: 10,
                    lineSpacing: 1.2,
                  ),
                ),
              );
            }).toList();
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'Optimized_Resume.pdf',
      );
    } catch (e) {
      debugPrint('PDF Generation Error: $e');
      Get.snackbar('Error', 'Failed to generate PDF. Please try again.');
    }
  }


  void logout() {
    _box.remove('is_logged_in');
    _box.remove('user_data');
    Get.offAllNamed(Routes.login);
  }

  @override
  void onClose() {
    jobDescriptionController.dispose();
    super.onClose();
  }
}
