import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navyDark,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.white.withOpacity(0.3),
            ),
            children: [
              const TextSpan(text: '© 2025 '),
              TextSpan(
                text: 'Your Name',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const TextSpan(
                text: '  ·  Flutter Developer  ·  Built with ❤️ in Pakistan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}