import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import 'shared_widgets.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _mainCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _mainCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _fadeAnim = CurvedAnimation(parent: _mainCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _mainCtrl, curve: Curves.easeOutCubic));
    _pulseAnim = Tween<double>(begin: 1.0, end: 0.4)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _mainCtrl.forward();
  }

  @override
  void dispose() {
    _mainCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final isMobile = w < 900;
    final isTablet = w >= 600 && w < 900;

    return Container(
      color: AppColors.navy,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 96,
        horizontal: isMobile ? 20 : (isTablet ? 40 : w * 0.08),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: isMobile
                  ? _buildMobile(context)
                  : _buildDesktop(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildText(context)),
        const SizedBox(width: 60),
        _buildAvatar(size: 240),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final avatarSize = w < 400 ? 140.0 : 180.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(size: avatarSize),
          const SizedBox(height: 32),
          _buildText(context, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildAvatar({double size = 240}) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gold.withOpacity(0.3),
              AppColors.gold.withOpacity(0.1),
            ],
          ),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.4),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/my_profile_image.jpeg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter, // 👈 Shows the top part (head)
            width: size,
            height: size,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.gold.withOpacity(0.2),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white54,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, {bool isMobile = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmall = screenWidth < 400;

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Available badge
        _buildBadge(isMobile: isMobile),
        const SizedBox(height: 22),

        // Name
        RichText(
          text: TextSpan(
            children: [
              // TextSpan(
              //   text: 'Muhammad\n',
              //   style: isMobile
              //       ? AppTextStyles.displayMobile
              //       : AppTextStyles.display,
              // ),
              TextSpan(
                text: 'Hamza Asad',
                style: (isMobile
                    ? AppTextStyles.displayMobile
                    : AppTextStyles.display)
                    .copyWith(color: AppColors.gold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Role
        Text(
          'Flutter Developer  ·  Firebase  ·  UI/UX',
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? (isVerySmall ? 12 : 14) : 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
        const SizedBox(height: 22),

        // Description
        Text(
          isMobile
              ? 'I build fast, beautiful cross-platform mobile apps for startups and businesses. 2+ years of hands-on experience delivering production Flutter apps.'
              : 'I build fast, beautiful cross-platform mobile apps for\nstartups and businesses. 2 years of hands-on experience\ndelivering production Flutter apps.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: AppTextStyles.bodyWhite.copyWith(
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 36),

        // CTA buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'View My Work  ↓',
              onTap: () {},
              bg: AppColors.gold,
              textColor: AppColors.navy,
            ),
            PrimaryButton(
              label: 'Get in Touch',
              onTap: () {},
              outlined: true,
            ),
          ],
        ),
        const SizedBox(height: 44),

        // Stats
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 36,
          runSpacing: 20,
          children: [
            _StatItem(value: '2+', label: 'Years Experience', isMobile: isMobile),
            _StatItem(value: '5+', label: 'Apps Built', isMobile: isMobile),
            _StatItem(value: '100%', label: 'Client Satisfaction', isMobile: isMobile),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge({required bool isMobile}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, __) => Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(_pulseAnim.value),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for freelance projects',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isMobile;

  const _StatItem({
    required this.value,
    required this.label,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final parts = value.replaceAll('%', '').replaceAll('+', '');
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: parts,
                  style: AppTextStyles.statVal.copyWith(
                    fontSize: isMobile ? 24 : 32,
                  )
              ),
              TextSpan(
                text: value.contains('%') ? '%' : value.contains('+') ? '+' : '',
                style: AppTextStyles.statVal.copyWith(
                  color: AppColors.gold,
                  fontSize: isMobile ? 24 : 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.statLabel.copyWith(
            fontSize: isMobile ? 11 : 14,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }
}