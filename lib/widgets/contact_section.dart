import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/theme.dart';
import 'shared_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w        = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    final cards = [
      const _CardData(
        icon:    Icons.email_outlined,
        label:   'Email',
        // detail:  'hamzaasad2026@gmail.com',
        caption: 'Tap to send an email',
        url:     'mailto:hamzaasad2026@gmail.com',
      ),
      const _CardData(
        icon:    Icons.whatshot,
        label:   'WhatsApp',
        // detail:  'W',
        caption: 'Tap to open WhatsApp',
        url:     'https://wa.me/923189547155',
      ),
      const _CardData(
        icon:    Icons.work_outline_rounded,
        label:   'LinkedIn',
        // detail:  'Linkedin account',
        caption: 'View profile',
        url:     'https://www.linkedin.com/in/hamzaasad-flutter-developer/',
      ),
      const _CardData(
        icon:    Icons.code_rounded,
        label:   'GitHub',
        // detail:  'Github account',
        caption: 'View repositories',
        url:     'https://github.com/hamzaasad5',
      ),
    ];

    return Container(
      color: AppColors.navy,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical:   isMobile ? 64 : AppSpacing.sectionPad,
        horizontal: isMobile ? 20 : w * 0.08,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label:    "Let's work together",
                title:    'Get In Touch',
                subtitle: 'Available for Flutter freelance projects. I respond within 24 hours.',
                darkBg:   true,
              ),
              const SizedBox(height: 16),
              _buildAvailabilityBadge(),
              const SizedBox(height: 40),

              // Grid: 2 columns on desktop/tablet, 1 on small mobile
              isMobile
                  ? _buildMobileGrid(cards)
                  : _buildDesktopGrid(cards),

              const SizedBox(height: 40),
              _buildResponseNote(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileGrid(List<_CardData> cards) {
    final w         = MediaQuery.of(context).size.width;
    final twoColumn = w >= 480;

    if (twoColumn) {
      return Column(
        children: [
          for (int i = 0; i < cards.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Expanded(child: _ContactCard(data: cards[i],    onTap: () => _launch(cards[i].url))),
                  const SizedBox(width: 14),
                  Expanded(child: _ContactCard(data: cards[i + 1], onTap: () => _launch(cards[i + 1].url))),
                ],
              ),
            ),
        ],
      );
    }

    return Column(
      children: cards
          .map((c) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: _ContactCard(data: c, onTap: () => _launch(c.url)),
      ))
          .toList(),
    );
  }

  Widget _buildDesktopGrid(List<_CardData> cards) {
    return Column(
      children: [
        for (int i = 0; i < cards.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(child: _ContactCard(data: cards[i],     onTap: () => _launch(cards[i].url))),
                const SizedBox(width: 16),
                Expanded(child: _ContactCard(data: cards[i + 1], onTap: () => _launch(cards[i + 1].url))),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:        AppColors.gold.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border:       Border.all(color: AppColors.gold.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              shape:     BoxShape.circle,
              color:     AppColors.gold,
              boxShadow: [
                BoxShadow(
                  color:      AppColors.gold.withOpacity(0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Available for new projects',
            style: GoogleFonts.plusJakartaSans(
              fontSize:   13,
              fontWeight: FontWeight.w600,
              color:      AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color:        Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
        border:       Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule_rounded,
            color: Colors.white.withOpacity(0.4),
            size:  20,
          ),
          const SizedBox(width: 12),
          Text(
            'Average response time · ',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color:    Colors.white.withOpacity(0.4),
            ),
          ),
          Text(
            'Within 24 hours',
            style: GoogleFonts.plusJakartaSans(
              fontSize:   13,
              fontWeight: FontWeight.w700,
              color:      Colors.white.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────

class _CardData {
  final IconData icon;
  final String   label;
  // final String   detail;
  final String   caption;
  final String   url;

  const _CardData({
    required this.icon,
    required this.label,
    // required this.detail,
    required this.caption,
    required this.url,
  });
}

// ── Card widget ──────────────────────────────────────────────────────

class _ContactCard extends StatefulWidget {
  final _CardData    data;
  final VoidCallback onTap;

  const _ContactCard({required this.data, required this.onTap});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;

    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding:  const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_hovered ? 0.09 : 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.gold.withOpacity(0.4)
                  : Colors.white.withOpacity(0.08),
              width: 1.2,
            ),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color:      AppColors.gold.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: icon + arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color:        AppColors.gold
                          .withOpacity(_hovered ? 0.22 : 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(d.icon, color: AppColors.gold, size: 24),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(_hovered ? 0.08 : 0.04),
                    ),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      size:  15,
                      color: Colors.white.withOpacity(_hovered ? 0.7 : 0.25),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Label
              Text(
                d.label.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize:      10,
                  color:         Colors.white.withOpacity(0.4),
                  fontWeight:    FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 5),

              // Detail
              // Text(
              //   d.detail,
              //   style: GoogleFonts.plusJakartaSans(
              //     fontSize:   14,
              //     color:      Colors.white,
              //     fontWeight: FontWeight.w600,
              //   ),
              //   maxLines:  1,
              //   overflow:  TextOverflow.ellipsis,
              // ),
              // const SizedBox(height: 4),

              // Caption
              Text(
                d.caption,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color:    Colors.white.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}