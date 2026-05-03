import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Background Gradient Glows
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF38BDF8).withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9D4EDD).withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Section ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'John Doe',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF38BDF8), Color(0xFF9D4EDD)],
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0xFF1E293B),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // --- Search Bar ---
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B).withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search for jobs or tools...',
                          hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                          icon: Icon(Icons.search, color: Colors.grey[400]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // --- Quick Stats ---
                    Row(
                      children: [
                        _buildMiniStat('95%', 'Success', Colors.cyan),
                        const SizedBox(width: 12),
                        _buildMiniStat('10x', 'Faster', Colors.blue),
                        const SizedBox(width: 12),
                        _buildMiniStat('50k+', 'Users', Colors.purple),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // --- Features Section ---
                    Text(
                      'Quick Actions',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildActionCard(
                      'Resume Shortlisting',
                      'Find best candidates using AI',
                      Icons.description_outlined,
                      const [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
                      () => Get.toNamed(Routes.cvshortlisting),
                    ),
                    const SizedBox(height: 16),
                    _buildActionCard(
                      'Resume Personalization',
                      'Get tailored AI career insights',
                      Icons.person_outline,
                      const [Color(0xFF6366F1), Color(0xFFA855F7)],
                      () => Get.toNamed(Routes.personalizatiion),
                    ),
                    const SizedBox(height: 16),
                    _buildActionCard(
                      'Find Dream Job',
                      'Jobs matching your skills',
                      Icons.work_outline,
                      const [Color(0xFF10B981), Color(0xFF3B82F6)],
                      () => Get.toNamed(Routes.findjob),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF0F172A),
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 20,
          top: 10,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home_rounded, true, onTap: () {}),
              _buildNavItem(Icons.work_outline, false,
                  onTap: () => Get.toNamed(Routes.findjob)),
              _buildNavItem(Icons.add_circle_rounded, false,
                  isSpecial: true,
                  onTap: () => Get.toNamed(Routes.createjob)),
              _buildNavItem(Icons.description_outlined, false,
                  onTap: () => Get.toNamed(Routes.cvshortlisting)),
              _buildNavItem(Icons.person_outline, false,
                  onTap: () => Get.toNamed(Routes.personalizatiion)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    String sub,
    IconData icon,
    List<Color> gradient,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sub,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[600],
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive,
      {bool isSpecial = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSpecial)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF38BDF8), Color(0xFF9D4EDD)],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF38BDF8).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            )
          else
            Column(
              children: [
                Icon(
                  icon,
                  color: isActive ? const Color(0xFF38BDF8) : Colors.grey[500],
                  size: 26,
                ),
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF38BDF8),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
