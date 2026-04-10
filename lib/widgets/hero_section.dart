import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';
import 'shared_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewMyWorkTap;
  final VoidCallback? onGetInTouchTap;
  final ScrollController? scrollController; // Add scroll controller

  const HeroSection({super.key,
    this.onViewMyWorkTap,
    this.onGetInTouchTap,
    this.scrollController});

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

  void _scrollToProjects() {
    widget.onViewMyWorkTap?.call();
  }

  void _scrollToContacDetails() {
    widget.onGetInTouchTap?.call();
  }


  // void _showContactDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: AppColors.navyMid,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Container(
  //           padding: const EdgeInsets.all(24),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             border: Border.all(color: AppColors.gold.withOpacity(0.3)),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(Icons.email, size: 50, color: AppColors.gold),
  //               const SizedBox(height: 16),
  //               Text(
  //                 'Get in Touch',
  //                 style: AppTextStyles.btnLabelLight.copyWith(color: AppColors.gold),
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 'Let\'s work together! Reach me at:',
  //                 style: AppTextStyles.bodyWhite,
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 20),
  //               Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.navy,
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: AppColors.gold.withOpacity(0.2)),
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.email, color: AppColors.gold, size: 20),
  //                     const SizedBox(width: 12),
  //                     Expanded(
  //                       child: Text(
  //                         'hamzaasad2026@gmail.com',
  //                         style: GoogleFonts.plusJakartaSans(
  //                           color: Colors.white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ),
  //                     InkWell(
  //                       onTap: () {
  //                         Clipboard.setData(
  //                           const ClipboardData(text: 'hamzaasad2026@gmail.com'),
  //                         ).then((_) {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             const SnackBar(
  //                               content: Text('Email copied to clipboard!'),
  //                               duration: Duration(seconds: 2),
  //                             ),
  //                           );
  //                         });
  //                       },
  //                       child: Icon(Icons.copy, color: AppColors.gold, size: 20),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: _buildContactButton(
  //                       icon: Icons.call,
  //                       label: 'Call',
  //                       onTap: () => _launchURL('tel:+923189547155'),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   Expanded(
  //                     child: _buildContactButton(
  //                       icon: Icons.message,
  //                       label: 'WhatsApp',
  //                       onTap: () => _launchURL('https://wa.me/+923189547155'),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 12),
  //               OutlinedButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 style: OutlinedButton.styleFrom(
  //                   side: BorderSide(color: AppColors.gold.withOpacity(0.5)),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //                 child: Text('Close', style: TextStyle(color: AppColors.gold)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.gold.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.gold, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
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

    // Don't wrap with SingleChildScrollView here - let the parent handle scrolling
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(size: avatarSize),
        const SizedBox(height: 32),
        _buildText(context, isMobile: true),
      ],
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
            alignment: Alignment.topCenter,
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
        _buildBadge(isMobile: isMobile),
        const SizedBox(height: 22),

        RichText(
          text: TextSpan(
            children: [
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

        Text(
          'Flutter Developer  ·  Firebase  ·  UI/UX',
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? (isVerySmall ? 12 : 14) : 18,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.55),
          ),
        ),
        const SizedBox(height: 22),

        Text(
          isMobile
              ? 'I build fast, beautiful cross-platform mobile apps for startups and businesses. 2+ years of hands-on experience delivering production Flutter apps.'
              : 'I build fast, beautiful cross-platform mobile apps for\nstartups and businesses. 2+ years of hands-on experience\ndelivering production Flutter apps.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: AppTextStyles.bodyWhite.copyWith(
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 36),

        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'View My Work  ↓',
              onTap: _scrollToProjects,
              bg: AppColors.gold,
              textColor: AppColors.navy,
            ),
            PrimaryButton(
              label: 'Get in Touch',
              onTap: _scrollToContacDetails,
              outlined: true,
            ),
          ],
        ),
        const SizedBox(height: 44),

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