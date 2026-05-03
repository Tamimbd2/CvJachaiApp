
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/findjob_controller.dart';

class FindjobView extends GetView<FindjobController> {
  const FindjobView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: Colors.cyan,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Available Positions',
                          style: GoogleFonts.inter(
                            color: Colors.cyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Find Your Dream ',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Job',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9D4EDD),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Explore opportunities that match your skills. Our AI-driven platform connects top talent with innovative companies.',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Job Cards
                  _buildJobCard(
                    'FD',
                    'Frontend Developer',
                    'TechNova Solutions',
                    'Dhaka, Bangladesh',
                    '1+ Years Exp.',
                    '10d ago',
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    'FD',
                    'Flutter Developer',
                    'AppNest',
                    'Remote',
                    '1+ Years Exp.',
                    '10d ago',
                    true, // Expanded
                  ),
                  const SizedBox(height: 16),
                  _buildJobCard(
                    'F&',
                    'Flutter & Python Developer',
                    'AT Tech',
                    'Dhaka (Remote Friendly)',
                    '2+ Years Exp.',
                    '10d ago',
                    false,
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      );
  }



  Widget _buildJobCard(
    String initials,
    String title,
    String company,
    String location,
    String exp,
    String time,
    bool isExpanded,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isExpanded ? Colors.cyan.withValues(alpha: 0.3) : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  initials,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _buildInfoIcon(Icons.business_outlined, company),
                        _buildInfoIcon(Icons.location_on_outlined, location),
                        _buildInfoIcon(Icons.attach_money_outlined, exp),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Active',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[600],
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  if (!isExpanded) ...[
                    const SizedBox(height: 16),
                    _buildApplyButton('Apply Now'),
                  ],
                ],
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 25),
            Text(
              'About the Role',
              style: GoogleFonts.inter(
                color: Colors.cyan,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Develop cross-platform mobile apps with Flutter.',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
            ),
            const SizedBox(height: 20),
            Text(
              'Required Skills',
              style: GoogleFonts.inter(
                color: Colors.cyan,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                _buildSkillItem('Flutter'),
                _buildSkillItem('Dart'),
                _buildSkillItem('Firebase'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                _buildApplyButton('Apply for this position', isLarge: true),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.cyan, size: 14),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillItem(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle_outline, color: Colors.cyan, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildApplyButton(String label, {bool isLarge = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 24 : 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D2FF).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: isLarge ? 14 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
