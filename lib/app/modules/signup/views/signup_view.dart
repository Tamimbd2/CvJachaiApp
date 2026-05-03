import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF38BDF8), Color(0xFF9D4EDD)],
                ).createShader(bounds),
                child: Text(
                  'CVJACHAI',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join the future of recruitment',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 40),

              // Names Row
              Row(
                children: [
                  Expanded(child: _buildNameField('First Name', 'John')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildNameField('Last Name', 'Doe')),
                ],
              ),
              const SizedBox(height: 24),

              // Email Field
              _buildLabel('Email Address'),
              const SizedBox(height: 10),
              _buildTextField(
                hint: 'name@company.com',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 24),

              // Password Field
              _buildLabel('Password'),
              const SizedBox(height: 10),
              _buildTextField(
                hint: '••••••••',
                icon: Icons.shield_outlined,
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // Confirm Password Field
              _buildLabel('Confirm Password'),
              const SizedBox(height: 10),
              _buildTextField(
                hint: '••••••••',
                icon: Icons.shield_outlined,
                isPassword: true,
              ),
              const SizedBox(height: 16),

              // Remember me
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: false,
                      onChanged: (v) {},
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Remember me',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Sign Up Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.navbar),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.white10)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.white10)),
                ],
              ),
              const SizedBox(height: 40),

              // Google Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png',
                        height: 18,
                        width: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Google অ্যাকাউন্ট দিয়ে সাইন-আপ করুন',
                        style: GoogleFonts.hindSiliguri(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Footer Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Login',
                      style: GoogleFonts.inter(
                        color: Colors.cyan,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 10),
        TextField(
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[600], fontSize: 15),
            prefixIcon:
                Icon(Icons.person_outline, color: Colors.grey[400], size: 20),
            filled: true,
            fillColor: const Color(0xFF1E293B).withValues(alpha: 0.4),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey[600], fontSize: 15),
        prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_outlined, color: Colors.grey[600], size: 20)
            : null,
        filled: true,
        fillColor: const Color(0xFF1E293B).withValues(alpha: 0.4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
        ),
      ),
    );
  }
}

