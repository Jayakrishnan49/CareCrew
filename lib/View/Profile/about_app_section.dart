
// import 'package:flutter/material.dart';
// import 'package:web_workout/appcolor.dart';
// import 'profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:project_2/View/profile/profile_page_main.dart';
import 'package:project_2/constants/app_color.dart';


class AboutAppSection extends StatelessWidget {
  const AboutAppSection({super.key});

  void _navigateToPage(BuildContext context, String title) {
    switch (title) {
      case 'Privacy Policy':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
        );
        break;
      case 'Terms & Conditions':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TermsConditionsPage()),
        );
        break;
      case 'Help Support':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpSupportPage()),
        );
        break;
      case 'About':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('ABOUT APP'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildMenuItem(
                context,
                Icons.shield_outlined,
                'Privacy Policy',
                false,
                isFirst: true,
              ),
              _buildDivider(),
              _buildMenuItem(
                context,
                Icons.description_outlined,
                'Terms & Conditions',
                false,
              ),
              _buildDivider(),
              _buildMenuItem(
                context,
                Icons.help_outline_rounded,
                'Help Support',
                false,
              ),
              _buildDivider(),
              _buildMenuItem(
                context,
                Icons.info_outline_rounded,
                'About',
                false,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.primary.withValues(alpha: 0.7),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    bool hasArrow, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _navigateToPage(context, title),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              if (hasArrow)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey.shade400,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 80),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade200,
      ),
    );
  }
}