import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';
import 'shared_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewMyWorkTap;
  final VoidCallback? onGetInTouchTap;
  final ScrollController? scrollController;

  const HeroSection({
    super.key,
    this.onViewMyWorkTap,
    this.onGetInTouchTap,
    this.scrollController,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {

  // ── Controllers ────────────────────────────────────────────────────
  late AnimationController _pulseCtrl;
  late AnimationController _badgeCtrl;
  late AnimationController _typeCtrl;
  late AnimationController _subtitleCtrl;
  late AnimationController _bodyCtrl;
  late AnimationController _buttonsCtrl;
  late AnimationController _statsCtrl;
  late AnimationController _avatarCtrl;

  // ── Animations ─────────────────────────────────────────────────────
  late Animation<double> _pulseAnim;
  late Animation<double> _badgeFade;
  late Animation<Offset> _badgeSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _bodyFade;
  late Animation<Offset> _bodySlide;
  late Animation<double> _buttonsFade;
  late Animation<Offset> _buttonsSlide;
  late Animation<double> _statsFade;
  late Animation<Offset> _statsSlide;
  late Animation<double> _avatarFade;
  late Animation<double> _avatarScale;

  // ── Typewriter state ───────────────────────────────────────────────
  final String _fullName = 'Hamza Asad';
  String _displayedName  = '';
  int    _typeIndex      = 0;

  @override
  void initState() {
    super.initState();
    _setupControllers();
    _setupAnimations();
    _startSequence();
  }

  void _setupControllers() {
    _pulseCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _badgeCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 500),
    );

    _typeCtrl = AnimationController(
      vsync:    this,
      // duration set dynamically in _startSequence
      duration: Duration(milliseconds: _fullName.length * 80),
    );

    _subtitleCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 500),
    );

    _bodyCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 500),
    );

    _buttonsCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 500),
    );

    _statsCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 600),
    );

    _avatarCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _setupAnimations() {
    _pulseAnim = Tween<double>(begin: 1.0, end: 0.3)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    // Badge
    _badgeFade  = CurvedAnimation(parent: _badgeCtrl,    curve: Curves.easeOut);
    _badgeSlide = Tween<Offset>(begin: const Offset(0, -0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: _badgeCtrl, curve: Curves.easeOutCubic));

    // Subtitle
    _subtitleFade  = CurvedAnimation(parent: _subtitleCtrl, curve: Curves.easeOut);
    _subtitleSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _subtitleCtrl, curve: Curves.easeOutCubic));

    // Body text
    _bodyFade  = CurvedAnimation(parent: _bodyCtrl, curve: Curves.easeOut);
    _bodySlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _bodyCtrl, curve: Curves.easeOutCubic));

    // Buttons
    _buttonsFade  = CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeOut);
    _buttonsSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _buttonsCtrl, curve: Curves.easeOutCubic));

    // Stats
    _statsFade  = CurvedAnimation(parent: _statsCtrl, curve: Curves.easeOut);
    _statsSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _statsCtrl, curve: Curves.easeOutCubic));

    // Avatar
    _avatarFade  = CurvedAnimation(parent: _avatarCtrl, curve: Curves.easeOut);
    _avatarScale = Tween<double>(begin: 0.75, end: 1.0)
        .animate(CurvedAnimation(parent: _avatarCtrl, curve: Curves.easeOutBack));
  }

  Future<void> _startSequence() async {
    // 1. Avatar
    await Future.delayed(const Duration(milliseconds: 100));
    _avatarCtrl.forward();

    // 2. Badge slides down
    await Future.delayed(const Duration(milliseconds: 200));
    _badgeCtrl.forward();

    // 3. Typewriter for name
    await Future.delayed(const Duration(milliseconds: 400));
    _typeWriter();

    // 4. Subtitle after name finishes
    final nameDuration = _fullName.length * 80;
    await Future.delayed(Duration(milliseconds: nameDuration + 100));
    _subtitleCtrl.forward();

    // 5. Body
    await Future.delayed(const Duration(milliseconds: 200));
    _bodyCtrl.forward();

    // 6. Buttons
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonsCtrl.forward();

    // 7. Stats
    await Future.delayed(const Duration(milliseconds: 200));
    _statsCtrl.forward();
  }

  void _typeWriter() {
    Future.doWhile(() async {
      if (!mounted) return false;
      await Future.delayed(const Duration(milliseconds: 75));
      if (!mounted) return false;
      setState(() {
        _displayedName = _fullName.substring(0, _typeIndex + 1);
        _typeIndex++;
      });
      return _typeIndex < _fullName.length;
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _badgeCtrl.dispose();
    _typeCtrl.dispose();
    _subtitleCtrl.dispose();
    _bodyCtrl.dispose();
    _buttonsCtrl.dispose();
    _statsCtrl.dispose();
    _avatarCtrl.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w        = MediaQuery.of(context).size.width;
    final isMobile = w < 900;
    final isTablet = w >= 600 && w < 900;

    return Container(
      color: AppColors.navy,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical:   isMobile ? 40 : 96,
        horizontal: isMobile ? 20 : (isTablet ? 40 : w * 0.08),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile
              ? _buildMobile(context)
              : _buildDesktop(context),
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
    final w          = MediaQuery.of(context).size.width;
    final avatarSize = w < 400 ? 140.0 : 180.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(size: avatarSize),
        const SizedBox(height: 32),
        _buildText(context, isMobile: true),
      ],
    );
  }

  // ── Avatar ─────────────────────────────────────────────────────────
  Widget _buildAvatar({double size = 240}) {
    return FadeTransition(
      opacity: _avatarFade,
      child: ScaleTransition(
        scale: _avatarScale,
        child: Center(
          child: Container(
            width: size, height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:   Alignment.bottomRight,
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
                  color:      AppColors.gold.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/my_profile_image.jpeg',
                fit:       BoxFit.cover,
                alignment: Alignment.topCenter,
                width:     size,
                height:    size,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.gold.withOpacity(0.2),
                  child: const Icon(Icons.person, size: 80, color: Colors.white54),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Text column ────────────────────────────────────────────────────
  Widget _buildText(BuildContext context, {bool isMobile = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmall = screenWidth < 400;

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [

        // 1. Badge
        FadeTransition(
          opacity: _badgeFade,
          child: SlideTransition(
            position: _badgeSlide,
            child: _buildBadge(isMobile: isMobile),
          ),
        ),
        const SizedBox(height: 22),

        // 2. Typewriter name + blinking cursor
        _buildTypewriterName(isMobile: isMobile),
        const SizedBox(height: 10),

        // 3. Subtitle
        FadeTransition(
          opacity: _subtitleFade,
          child: SlideTransition(
            position: _subtitleSlide,
            child: Text(
              'Flutter Developer  ·  Firebase  ·  UI/UX',
              style: GoogleFonts.plusJakartaSans(
                fontSize:   isMobile ? (isVerySmall ? 12 : 14) : 18,
                fontWeight: FontWeight.w500,
                color:      Colors.white.withOpacity(0.55),
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),

        // 4. Body paragraph
        FadeTransition(
          opacity: _bodyFade,
          child: SlideTransition(
            position: _bodySlide,
            child: Text(
              isMobile
                  ? 'I build fast, beautiful cross-platform mobile apps for startups and businesses. 2+ years of hands-on experience delivering production Flutter apps.'
                  : 'I build fast, beautiful cross-platform mobile apps for\nstartups and businesses. 2+ years of hands-on experience\ndelivering production Flutter apps.',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: AppTextStyles.bodyWhite.copyWith(
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),

        // 5. Buttons
        FadeTransition(
          opacity: _buttonsFade,
          child: SlideTransition(
            position: _buttonsSlide,
            child: Wrap(
              alignment:   isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing:     12,
              runSpacing:  12,
              children: [
                PrimaryButton(
                  label:     'View My Work  ↓',
                  onTap:     () => widget.onViewMyWorkTap?.call(),
                  bg:        AppColors.gold,
                  textColor: AppColors.navy,
                ),
                PrimaryButton(
                  label:    'Get in Touch',
                  onTap:    () => widget.onGetInTouchTap?.call(),
                  outlined: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 44),

        // 6. Stats
        FadeTransition(
          opacity: _statsFade,
          child: SlideTransition(
            position: _statsSlide,
            child: Wrap(
              alignment:  isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing:    36,
              runSpacing: 20,
              children: [
                _StatItem(value: '2+',   label: 'Years Experience',   isMobile: isMobile),
                _StatItem(value: '5+',   label: 'Apps Built',         isMobile: isMobile),
                _StatItem(value: '100%', label: 'Client Satisfaction', isMobile: isMobile),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Typewriter name with blinking cursor ───────────────────────────
  Widget _buildTypewriterName({required bool isMobile}) {
    final nameStyle = (isMobile
        ? AppTextStyles.displayMobile
        : AppTextStyles.display)
        .copyWith(color: AppColors.gold);

    final isDone = _displayedName.length == _fullName.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
      isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(_displayedName, style: nameStyle),
        // Blinking cursor — hides once typing is done
        if (!isDone)
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) => Opacity(
              opacity: _pulseAnim.value,
              child: Text('|', style: nameStyle),
            ),
          ),
      ],
    );
  }

  // ── Badge ──────────────────────────────────────────────────────────
  Widget _buildBadge({required bool isMobile}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color:        AppColors.gold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (_, __) => Container(
              width: 7, height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(_pulseAnim.value),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for projects',
            style: GoogleFonts.plusJakartaSans(
              fontSize:   12,
              fontWeight: FontWeight.w600,
              color:      AppColors.gold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat Item ──────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool   isMobile;

  const _StatItem({
    required this.value,
    required this.label,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final parts = value.replaceAll('%', '').replaceAll('+', '');
    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:  parts,
                style: AppTextStyles.statVal.copyWith(
                  fontSize: isMobile ? 24 : 32,
                ),
              ),
              TextSpan(
                text: value.contains('%')
                    ? '%'
                    : value.contains('+')
                    ? '+'
                    : '',
                style: AppTextStyles.statVal.copyWith(
                  color:    AppColors.gold,
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