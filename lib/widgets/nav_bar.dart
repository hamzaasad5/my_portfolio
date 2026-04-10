import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';
import 'shared_widgets.dart';

class PortfolioNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  final List<String> _labels = ['Skills', 'Projects', 'Experience', 'Contact'];

  void _scrollTo(int index) {
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return Container(
      height: 60,
      color: AppColors.navy,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : w * 0.08),
      child: Row(
        children: [
          // Logo
          Text(
            'Hamza Asad',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            '',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.gold,
            ),
          ),

          const Spacer(),

          // Nav links — desktop only
          if (!isMobile)
            Row(
              children: List.generate(_labels.length, (i) {
                return _NavLink(
                  label: _labels[i],
                  onTap: () => _scrollTo(i),
                );
              }),
            ),

          if (!isMobile) const SizedBox(width: 20),

          // Hire Me CTA
          _HireMeBtn(),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Text(
            widget.label,
            style: AppTextStyles.navLabel.copyWith(
              color: _hovered ? AppColors.gold : const Color(0xBBFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class _HireMeBtn extends StatefulWidget {
  @override
  State<_HireMeBtn> createState() => _HireMeBtnState();
}

class _HireMeBtnState extends State<_HireMeBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse('https://wa.me/+923189547155'));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(_hovered ? 0.88 : 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Hire Me',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
        ),
      ),
    );
  }
}