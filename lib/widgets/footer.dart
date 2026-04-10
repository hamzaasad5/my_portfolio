import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navyDark,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Social Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIconButton(
                icon: Icons.code, // GitHub placeholder — replace with font_awesome if available
                tooltip: 'GitHub',
                onTap: () => _launchURL('https://github.com/hamzaasad5'),
              ),
              const SizedBox(width: 16),
              _SocialIconButton(
                icon: Icons.work_outline,
                tooltip: 'LinkedIn',
                onTap: () => _launchURL('https://www.linkedin.com/in/hamzaasad-flutter-developer/'),
              ),
              const SizedBox(width: 16),
              _SocialIconButton(
                icon: Icons.email_outlined,
                tooltip: 'Email',
                onTap: () => _launchURL('mailto:hamzaasad2026@gmail.com'),
              ),
              const SizedBox(width: 16),
              _SocialIconButton(
                icon: Icons.message_outlined,
                tooltip: 'WhatsApp',
                onTap: () => _launchURL('https://wa.me/+923189547155'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Divider
          Container(
            height: 1,
            width: 200,
            color: Colors.white.withOpacity(0.08),
          ),

          const SizedBox(height: 20),

          // Copyright text
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: Colors.white.withOpacity(0.3),
              ),
              children: [
                const TextSpan(text: '© 2025 '),
                TextSpan(
                  text: 'Hamza Asad',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const TextSpan(
                  text: '  ·  All rights reserved  ·  Made with ❤️ in Pakistan',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? AppColors.gold.withOpacity(0.15)
                  : Colors.white.withOpacity(0.05),
              border: Border.all(
                color: _hovered
                    ? AppColors.gold.withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovered ? AppColors.gold : Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}