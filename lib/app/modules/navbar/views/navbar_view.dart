import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';
import '../../home/views/home_view.dart';
import '../../findjob/views/findjob_view.dart';
import '../../cvshortlisting/views/cvshortlisting_view.dart';
import '../../personalizatiion/views/personalizatiion_view.dart';
import '../../../routes/app_pages.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  HomeView(),
                  FindjobView(),
                  SizedBox(), // Placeholder for special Add button
                  CvshortlistingView(),
                  PersonalizatiionView(),
                ],
              )),
          _buildCustomNavBar(context),
        ],
      ),
    );
  }

  Widget _buildCustomNavBar(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Positioned(
      bottom: bottomPadding + 10,
      left: 24,
      right: 24,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home_rounded, 0),
            _buildNavItem(Icons.work_outline, 1),
            _buildNavItem(
              Icons.add_circle_rounded,
              2,
              isSpecial: true,
              onTap: () => Get.toNamed(Routes.createjob),
            ),
            _buildNavItem(Icons.description_outlined, 3),
            _buildNavItem(Icons.person_outline, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    int index, {
    bool isSpecial = false,
    VoidCallback? onTap,
  }) {
    return Obx(() {
      final isActive = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: onTap ?? () => controller.changePage(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isSpecial ? 12 : 8),
              decoration: isSpecial
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF38BDF8), Color(0xFF9D4EDD)],
                      ),
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Icon(
                icon,
                color: isActive ? const Color(0xFF38BDF8) : Colors.grey[400],
                size: isSpecial ? 28 : 24,
              ),
            ),
            if (isActive && !isSpecial)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF38BDF8),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      );
    });
  }
}
